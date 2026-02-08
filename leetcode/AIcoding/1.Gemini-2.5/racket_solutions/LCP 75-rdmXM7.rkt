#lang racket

(struct heap (data size) #:mutable)

(define (make-min-heap)
  ;; Pre-allocate a reasonable size for the underlying vector.
  ;; This can be adjusted based on problem constraints (e.g., max N or M).
  (heap (make-vector 100000) 0))

(define (heap-empty? h)
  (zero? (heap-size h)))

(define (heap-push! h item)
  (let* ([current-size (heap-size h)]
         [data-vec (heap-data h)])
    ;; Resize if necessary (simple doubling strategy)
    (when (>= current-size (vector-length data-vec))
      (let* ([new-capacity (* (vector-length data-vec) 2)]
             [new-vec (make-vector (max new-capacity 1))])
        (for ([i (range current-size)])
          (vector-set! new-vec i (vector-ref data-vec i)))
        (set-heap-data! h new-vec)))

    (vector-set! (heap-data h) current-size item)
    (set-heap-size! h (+ current-size 1))
    (heapify-up! h current-size)))

(define (heapify-up! h idx)
  (let ([data-vec (heap-data h)])
    (when (> idx 0)
      (let* ([parent-idx (floor (/ (- idx 1) 2))]
             [current-cost (car (vector-ref data-vec idx))]
             [parent-cost (car (vector-ref data-vec parent-idx))])
        (when (< current-cost parent-cost)
          (let ([temp (vector-ref data-vec idx)])
            (vector-set! data-vec idx (vector-ref data-vec parent-idx))
            (vector-set! data-vec parent-idx temp))
          (heapify-up! h parent-idx))))))

(define (heap-pop! h)
  (if (heap-empty? h)
      (error "Heap is empty")
      (let* ([data-vec (heap-data h)]
             [current-size (heap-size h)]
             [min-item (vector-ref data-vec 0)])
        (set-heap-size! h (- current-size 1))
        (let ([new-size (heap-size h)])
          (when (> new-size 0)
            (vector-set! data-vec 0 (vector-ref data-vec new-size)) ; Move last item to root
            (heapify-down! h 0)))
        min-item)))

(define (heapify-down! h idx)
  (let* ([data-vec (heap-data h)]
         [current-size (heap-size h)]
         [left-child-idx (+ (* 2 idx) 1)]
         [right-child-idx (+ (* 2 idx) 2)]
         [smallest-idx idx])
    (when (< left-child-idx current-size)
      (when (< (car (vector-ref data-vec left-child-idx)) (car (vector-ref data-vec smallest-idx)))
        (set! smallest-idx left-child-idx)))
    (when (< right-child-idx current-size)
      (when (< (car (vector-ref data-vec right-child-idx)) (car (vector-ref data-vec smallest-idx)))
        (set! smallest-idx right-child-idx)))
    (when (not (= smallest-idx idx))
      (let ([temp (vector-ref data-vec idx)])
        (vector-set! data-vec idx (vector-ref data-vec smallest-idx))
        (vector-set! data-vec smallest-idx temp))
      (heapify-down! h smallest-idx))))

(define (teleport-scroll n teleports)
  ;; n: number of locations (0 to n-1)
  ;; teleports: list of (u v cost)

  ;; Build adjacency list
  (define adj (make-hash))
  (for ([i (range n)])
    (hash-set! adj i '()))

  ;; Add regular moves: i <-> i+1 with cost 1 (bidirectional)
  (for ([i (range (- n 1))])
    (hash-update! adj i (lambda (edges) (cons (list (+ i 1) 1) edges)))
    (hash-update! adj (+ i 1) (lambda (edges) (cons (list i 1) edges))))

  ;; Add teleport moves: u -> v with specified cost (one-way)
  (for ([t teleports])
    (define u (car t))
    (define v (cadr t))
    (define cost (caddr t))
    (when (and (>= u 0) (< u n) (>= v 0) (< v n)) ; Ensure valid indices
      (hash-update! adj u (lambda (edges) (cons (list v cost) edges)))))

  ;; Dijkstra's algorithm
  (define dist (make-vector n +inf.0)) ; Use vector for O(1) access to distances
  (vector-set! dist 0 0) ; Start at location 0 with cost 0

  (define pq (make-min-heap))
  (heap-push! pq (list 0 0)) ; Push (cost node) pair for the starting node

  (define (dijkstra-loop)
    (unless (heap-empty? pq)
      (let* ([min-item (heap-pop! pq)]
             [current-cost (car min-item)]
             [u (cadr min-item)])

        ;; If we've found a shorter path to u already, skip this entry
        (when (<= current-cost (vector-ref dist u))
          (for ([edge (hash-ref adj u '())])
            (define v (car edge))
            (define weight (cadr edge))
            (when (< (+ current-cost weight) (vector-ref dist v))
              (vector-set! dist v (+ current-cost weight))
              (heap-push! pq (list (vector-ref dist v) v)))))
        (dijkstra-loop)))) ; Continue the loop

  (dijkstra-loop)

  (define result (vector-ref dist (- n 1)))
  (if (= result +inf.0)
      -1 ; Target is unreachable
      result))