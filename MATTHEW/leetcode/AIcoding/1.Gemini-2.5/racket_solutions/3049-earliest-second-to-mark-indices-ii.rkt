#lang racket

(require data/heap)

(define (earliest-second-to-mark-indices-ii nums changeIndices)
  (define n (vector-length nums))
  (define m (vector-length changeIndices))

  (define (check t)
    (call/cc
     (lambda (return)
       (define last-occurrence (make-vector n -1))
       (for ([k (in-range m)])
         (when (<= (+ k 1) t)
           (vector-set! last-occurrence (vector-ref changeIndices k) (+ k 1))))

       (for ([j (in-range n)])
         (when (= (vector-ref last-occurrence j) -1)
           (return #f)))

       (define pq (make-heap >)) ; Max-heap
       (define total-decrease-cost 0)
       (define marked-count 0)
       (define available-slots 0)

       (define current-time-ptr t) ; Tracks the highest second considered so far in the reverse loop

       (for ([k (in-range (sub1 m) -1 -1)]) ; Iterate from m-1 down to 0 (seconds s from m down to 1)
         (define s (+ k 1))
         (when (> s t)
           (continue))) ; Skip if this operation is beyond time t

         ; Seconds from `s+1` to `current-time-ptr` are "free" slots.
         (set! available-slots (+ available-slots (- current-time-ptr s)))
         (set! current-time-ptr s)

         (define idx (vector-ref changeIndices k))
         (when (= (vector-ref last-occurrence idx) s) ; This is the last second to mark `idx`
           (if (> (vector-ref nums idx) 0)
               (heap-insert! pq (vector-ref nums idx))
               (set! marked-count (+ marked-count 1))))

         ; Process any available slots
         (while (and (not (heap-empty? pq)) (> available-slots 0))
           (define val (heap-extract-top! pq))
           (set! total-decrease-cost (+ total-decrease-cost val))
           (set! marked-count (+ marked-count 1))
           (set! available-slots (- available-slots 1))))

       ; After the loop, account for remaining slots from `current-time-ptr` down to `1`
       (set! available-slots (+ available-slots (- current-time-ptr 0)))
       (while (and (not (heap-empty? pq)) (> available-slots 0))
         (define val (heap-extract-top! pq))
         (set! total-decrease-cost (+ total-decrease-cost val))
         (set! marked-count (+ marked-count 1))
         (set! available-slots (- available-slots 1)))

       (and (= marked-count n) (<= (+ total-decrease-cost n) t)))))

  ; Binary search for the minimum t
  (define low n) ; Minimum time is n (to mark n indices, each taking 1 second)
  (define high (+ (apply + 0 (vector->list nums)) n)) ; Max possible time: sum of all nums + n for marking
  (define ans -1)

  (let loop ([low low] [high high])
    (when (<= low high)
      (define mid (+ low (quotient (- high low) 2)))
      (if (check mid)
          (begin
            (set! ans mid)
            (loop low (sub1 mid)))
          (loop (add1 mid) high))))
  ans)