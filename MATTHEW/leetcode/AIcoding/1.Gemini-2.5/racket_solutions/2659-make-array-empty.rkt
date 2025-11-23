#lang racket

(require racket/vector)
(require racket/hash)
(require racket/sort)
(require math/bitwise)

(struct fenwick-tree (data size) #:transparent)

(define (make-fenwick-tree size)
  (fenwick-tree (make-vector (+ size 1) 0) size))

(define (fenwick-tree-update! ft idx val)
  (let* ((data (fenwick-tree-data ft))
         (ft-size (fenwick-tree-size ft))
         (actual-idx (+ idx 1)))
    (let loop ((i actual-idx))
      (when (<= i ft-size)
        (vector-set! data i (+ (vector-ref data i) val))
        (loop (+ i (bitwise-and i (- i))))))))

(define (fenwick-tree-query ft idx)
  (if (< idx 0)
      0
      (let* ((data (fenwick-tree-data ft))
             (actual-idx (+ idx 1)))
        (let loop ((i actual-idx) (sum 0))
          (if (> i 0)
              (loop (- i (bitwise-and i (- i))) (+ sum (vector-ref data i)))
              sum)))))

(define (make-array-empty nums)
  (let* ((n (vector-length nums))
         (val-to-original-idx (make-hash))
         (sorted-pairs (make-vector n)))

    (for ([val (in-vector nums)]
          [idx (in-range n)])
      (hash-set! val-to-original-idx val idx)
      (vector-set! sorted-pairs idx (cons val idx)))

    (vector-sort! sorted-pairs (lambda (a b) (< (car a) (car b))))

    (let* ((ft (make-fenwick-tree n))
           (total-cost 0)
           (current-pos 0)
           (n-available n))

      (for ([i (in-range n)])
        (fenwick-tree-update! ft i 1))

      (for ([pair (in-vector sorted-pairs)])
        (let* ((val (car pair))
               (original-idx (cdr pair))
               (current-0-based-rank-of-val (- (fenwick-tree-query ft original-idx) 1)))

          (let ((elements-to-pass 0))
            (if (>= current-0-based-rank-of-val current-pos)
                (set! elements-to-pass (- current-0-based-rank-of-val current-pos))
                (set! elements-to-pass (+ (- n-available current-pos) current-0-based-rank-of-val)))

            (set! total-cost (+ total-cost elements-to-pass 1))
            (set! current-pos current-0-based-rank-of-val)
            (fenwick-tree-update! ft original-idx -1)
            (set! n-available (- n-available 1)))))
      total-cost)))