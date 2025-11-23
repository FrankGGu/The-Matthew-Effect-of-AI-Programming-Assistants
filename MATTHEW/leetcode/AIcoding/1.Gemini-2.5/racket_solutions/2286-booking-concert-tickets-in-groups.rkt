#lang racket

(define (book-my-show n m)
  (define rows-filled (make-vector n 0)) ; vector of n zeros
  (define next-available-row (box 0)) ; mutable integer for the next row to check

  ;; Segment Tree
  ;; tree-min-occupied: stores min(rows-filled[i]) in range
  ;; tree-total-available: stores sum(m - rows-filled[i]) in range
  (define tree-min-occupied (make-vector (* 4 n) 0))
  (define tree-total-available (make-vector (* 4 n) 0))

  ;; Helper to get/set next-available-row
  (define (get-next-available-row) (unbox next-available-row))
  (define (set-next-available-row! val) (set-box! next-available-row val))

  ;; Helper to update next-available-row
  ;; This ensures next-available-row always points to the first row that is not full, or N if all are full.
  (define (update-next-available-row!)
    (let loop ((r (get-next-available-row)))
      (cond
        ((>= r n) (set-next-available-row! n)) ; All rows full or beyond
        ((< (vector-ref rows-filled r) m) (set-next-available-row! r)) ; Found a non-full row
        (else (loop (+ r 1)))))) ; Current row is full, check next

  ;; Segment Tree Build
  (define (build node tl tr)
    (if (= tl tr)
        (begin
          (vector-set! tree-min-occupied node (vector-ref rows-filled tl))
          (vector-set! tree-total-available node (- m (vector-ref rows-filled tl))))
        (let* ((tm (quotient (+ tl tr) 2))
               (left-child (* 2 node))
               (right-child (+ (* 2 node) 1)))
          (build left-child tl tm)
          (build right-child (+ tm 1) tr)
          (vector-set! tree-min-occupied node (min (vector-ref tree-min-occupied left-child)
                                                    (vector-ref tree-min-occupied right-child)))
          (vector-set! tree-total-available node (+ (vector-ref tree-total-available left-child)
                                                     (vector-ref tree-total-available right-child))))))

  ;; Segment Tree Update
  (define (update node tl tr pos new-val)
    (if (= tl tr)
        (begin
          (vector-set! tree-min-occupied node new-val)
          (vector-set! tree-total-available node (- m new-val)))
        (let* ((tm (quotient (+ tl tr) 2))
               (left-child (* 2 node))
               (right-child (+ (* 2 node) 1)))
          (if (<= tl pos tm)
              (update left-child tl tm pos new-val)
              (update right-child (+ tm 1) tr pos new-val))
          (vector-set! tree-min-occupied node (min (vector-ref tree-min-occupied left-child)
                                                    (vector-ref tree-min-occupied right-child)))
          (vector-set! tree-total-available node (+ (vector-ref tree-total-available left-child)
                                                     (vector-ref tree-total-available right-child))))))

  ;; Query for gather: find first row `r` in [query_L, query_R] such that `m - rows-filled[r] >= k`
  ;; i.e., `rows-filled[r] <= m - k`
  (define (query-gather node tl tr query_L query_R k-tickets)
    (cond
      ((or (> tl query_R) (< tr query_L) (> (+ (vector-ref tree-min-occupied node) k-tickets) m))
       -1) ; No suitable row in this range
      ((= tl tr) ; Leaf node, and we already know it satisfies
       tl)
      (else
       (let* ((tm (quotient (+ tl tr) 2))
              (left-child (* 2 node))
              (right-child (+ (* 2 node) 1))
              (res-left (query-gather left-child tl tm query_L query_R k-tickets)))
         (if (!= res-left -1)
             res-left ; Found in left child
             (query-gather right-child (+ tm 1) tr query_L query_R k-tickets)))))) ; Try right child

  ;; Query for scatter total available: sum of (m - rows-filled[i]) in range [query_L, query_R]
  (define (query-total-available node tl tr query_L query_R)
    (cond
      ((or (> tl query_R) (< tr query_L))
       0) ; Outside query range
      ((and (>= tl query_L) (<= tr query_R))
       (vector-ref tree-total-available node)) ; Current node fully within query range
      (else
       (let* ((tm (quotient (+ tl tr) 2))
              (left-child (* 2 node))
              (right-child (+ (* 2 node) 1)))
         (+ (query-total-available left-child tl tm query_L query_R)
            (query-total-available right-child (+ tm 1) tr query_L query_R))))))

  ;; Query for scatter first available row: find first row `r` in [query_L, query_R] with `rows-filled[r] < m`
  (define (query-first-available-row node tl tr query_L query_R)
    (cond
      ((or (> tl query_R) (< tr query_L) (= (vector-ref tree-min-occupied node) m))
       -1) ; No available row in this range
      ((= tl tr) ; Leaf node, and we know it has available seats
       tl)
      (else
       (let* ((tm (quotient (+ tl tr) 2))
              (left-child (* 2 node))
              (right-child (+ (* 2 node) 1))
              (res-left (query-first-available-row left-child tl tm query_L query_R)))
         (if (!= res-left -1)
             res-left ; Found in left child
             (query-first-available-row right-child (+ tm 1) tr query_L query_R)))))) ; Try right child

  ;; Build the segment tree initially
  (build 1 0 (- n 1))

  (define (gather k max-row)
    (let ((r (query-gather 1 0 (- n 1) (get-next-available-row) max-row k)))
      (if (= r -1)
          (list)
          (let ((col-start (vector-ref rows-filled r)))
            (vector-set! rows-filled r (+ col-start k))
            (update 1 0 (- n 1) r (vector-ref rows-filled r))
            (update-next-available-row!) ; Update next-available-row after booking
            (list r col-start)))))

  (define (scatter k max-row)
    (let* ((actual-max-row (min (- n 1) max-row))
           (available-seats (query-total-available 1 0 (- n 1) (get-next-available-row) actual-max-row)))
      (if (< available-seats k)
          (list)
          (let ((first-r -1)
                (first-c -1)
                (remaining-k k))
            (let loop-booking ()
              (when (> remaining-k 0)
                (let* ((r (query-first-available-row 1 0 (- n 1) (get-next-available-row) actual-max-row)))
                  ;; If r is -1, it means no more available rows in the range, which contradicts
                  ;; the initial `available-seats >= k` check. This should not happen.
                  (when (= r -1) (error 'scatter "Logic error: no available row found for scatter"))
                  (let* ((seats-in-row (vector-ref rows-filled r))
                         (available-in-row (- m seats-in-row))
                         (seats-to-book (min remaining-k available-in-row)))

                    (when (= first-r -1)
                      (set! first-r r)
                      (set! first-c seats-in-row))

                    (vector-set! rows-filled r (+ seats-in-row seats-to-book))
                    (update 1 0 (- n 1) r (vector-ref rows-filled r))
                    (set! remaining-k (- remaining-k seats-to-book))))
                (loop-booking)))
            (update-next-available-row!) ; Update next-available-row after all bookings
            (list first-r first-c))))))

  ;; Dispatch function
  (lambda (method . args)
    (case method
      ((gather) (apply gather args))
      ((scatter) (apply scatter args))
      (else (error "unknown method" method)))))