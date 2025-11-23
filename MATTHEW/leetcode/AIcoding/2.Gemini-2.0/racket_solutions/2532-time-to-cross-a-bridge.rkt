(define (time-to-cross-bridge left right time-per-person k)
  (let* ([n (length left)]
         [time-to-cross (make-vector n 0)]
         [people (make-vector n 0)]
         [pq-left (make-heap <)]
         [pq-right (make-heap <)]
         [pq-available (make-heap <)]
         [pq-back (make-heap <)]
         [time 0])

    (for/list ([i (in-range n)])
      (vector-set! time-to-cross i (+ (list-ref left i) (list-ref right i)))
      (vector-set! people i i))

    (let loop ([left-count n] [right-count 0])
      (cond
        [(zero? left-count)
         (if (heap-empty? pq-right)
             time
             (let ([idx (heap-top pq-right)])
               (set! time (+ time (vector-ref time-to-cross idx)))
               time))]
        [else
         (begin
           ; Move people to the available queue
           (for ([i (in-range n)])
             (when (and (< (vector-ref people i) left-count) (not (heap-member? pq-right i)))
               (heap-add! pq-available (- (vector-ref time-to-cross i)) i)))

           ; Choose the two fastest people to cross
           (let ([first-person (if (heap-empty? pq-available) #f (heap-top pq-available))]
                 [second-person (if (<= (heap-count pq-available) 1) #f
                                     (let ([temp-heap (make-heap <)])
                                       (heap-add! temp-heap (heap-remove! pq-available))
                                       (let ([second (heap-top pq-available)])
                                         (heap-add! pq-available (heap-remove! temp-heap))
                                         second)))])

             (cond
               [(not first-person)
                (set! time (+ time 1))
                (loop left-count right-count)] ; No one available, wait
               [second-person
                (let ([first-idx (heap-remove! pq-available)]
                      [second-idx (heap-remove! pq-available)])
                  (set! time (+ time (max (list-ref left (vector-ref people first-idx)) (list-ref left (vector-ref people second-idx)))))
                  ; Move people to the back queue
                  (heap-add! pq-back (- (max (list-ref right (vector-ref people first-idx)) (list-ref right (vector-ref people second-idx)))) first-idx)
                  (heap-add! pq-back (- (max (list-ref right (vector-ref people first-idx)) (list-ref right (vector-ref people second-idx)))) second-idx)
                  (vector-set! people first-idx (+ left-count right-count))
                  (vector-set! people second-idx (+ left-count right-count))
                  (loop (- left-count 2) (+ right-count 2)))]
               [else
                (let ([first-idx (heap-remove! pq-available)])
                  (set! time (+ time (list-ref left (vector-ref people first-idx))))
                  (heap-add! pq-back (- (list-ref right (vector-ref people first-idx))) first-idx)
                  (vector-set! people first-idx (+ left-count right-count))
                  (loop (- left-count 1) (+ right-count 1)))]))]

           ; Move people back from right to left
           (when (and (not (heap-empty? pq-back)) (<= k (+ left-count right-count)))
             (let ([back-idx (heap-remove! pq-back)])
               (heap-add! pq-right (- (vector-ref time-to-cross back-idx)) back-idx)))
           ))))))