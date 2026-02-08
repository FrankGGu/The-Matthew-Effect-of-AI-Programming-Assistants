#lang racket

(define (make-fenwick-tree size)
  (build-vector size (lambda (i) (make-hash))))

(define (fenwick-update! bit-arr idx val delta)
  (let loop ((i (+ idx 1))) ; Convert to 1-indexed for BIT logic
    (when (<= i (vector-length bit-arr))
      (let ((h (vector-ref bit-arr (- i 1))))
        (hash-set! h val (+ (hash-ref h val 0) delta)))
      (loop (+ i (bitwise-and i (- i)))))))

(define (fenwick-query bit-arr idx val)
  (let loop ((i (+ idx 1)) (sum 0)) ; Convert to 1-indexed for BIT logic
    (when (> i 0)
      (let ((h (vector-ref bit-arr (- i 1))))
        (loop (- i (bitwise-and i (- i))) (+ sum (hash-ref h val 0)))))
    sum))

(define (solve N initial_values edges queries)
  (define adj (make-vector N '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define subtree-sz (make-vector N 0))
  (define flat-tree-idx (make-vector N 0))
  (define nodes-in-dfs-order (make-vector N 0))
  (define time-counter (vector 0)) ; mutable counter for DFS time

  (define (dfs u p)
    (let ((current-time (vector-ref time-counter 0)))
      (vector-set! flat-tree-idx u current-time)
      (vector-set! nodes-in-dfs-order current-time u)
      (vector-set! time-counter 0 (+ current-time 1)))
    (vector-set! subtree-sz u 1)
    (for-each (lambda (v)
                (when (not (= v p))
                  (dfs v u)
                  (vector-set! subtree-sz u (+ (vector-ref subtree-sz u) (vector-ref subtree-sz v)))))
              (vector-ref adj u)))

  (dfs 0 -1) ; Start DFS from node 0, parent -1

  (define current-node-values (vector-copy initial_values))

  ; Initialize Fenwick tree
  (define bit-arr (make-fenwick-tree N))

  ; Build initial state of Fenwick tree
  (for-each (lambda (u)
              (fenwick-update! bit-arr (vector-ref flat-tree-idx u)
                               (vector-ref current-node-values u)
                               (vector-ref subtree-sz u)))
            (build-list N identity)) ; iterate u from 0 to N-1

  (define results '())

  (for-each (lambda (q)
              (let ((type (car q)))
                (cond
                  ((= type 1) ; Type 1 query: change value
                   (let* ((u (cadr q))
                          (new-val (caddr q))
                          (old-val (vector-ref current-node-values u))
                          (node-dfs-idx (vector-ref flat-tree-idx u))
                          (sz (vector-ref subtree-sz u)))
                     ; Remove old value's contribution
                     (fenwick-update! bit-arr node-dfs-idx old-val (- sz))
                     ; Add new value's contribution
                     (fenwick-update! bit-arr node-dfs-idx new-val sz)
                     (vector-set! current-node-values u new-val)))
                  ((= type 2) ; Type 2 query: find sum of subtree sizes
                   (let* ((u (cadr q))
                          (target-val (caddr q))
                          (u-dfs-idx (vector-ref flat-tree-idx u))
                          (u-subtree-size (vector-ref subtree-sz u))
                          (query-start u-dfs-idx)
                          (query-end (+ u-dfs-idx u-subtree-size -1)))
                     ; Query sum for range [query-start, query-end] for target_val
                     ; This is query(query_end) - query(query_start - 1)
                     (let ((res (+ (fenwick-query bit-arr query-end target-val)
                                   (- (if (> query-start 0)
                                          (fenwick-query bit-arr (- query-start 1) target-val)
                                          0)))))
                       (set! results (cons res results)))))))
            queries)
  (reverse results))