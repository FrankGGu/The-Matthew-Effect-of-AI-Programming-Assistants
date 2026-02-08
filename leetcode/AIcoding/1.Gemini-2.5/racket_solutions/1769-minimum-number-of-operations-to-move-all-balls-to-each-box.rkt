(define (min-operations boxes)
  (let* ([n (string-length boxes)]
         [ans (make-vector n 0)])

    ;; First pass: calculate cost from balls to the left
    (let loop-left ([i 0]
                    [left-count 0]
                    [left-sum-dist 0])
      (when (< i n)
        (vector-set! ans i (+ (vector-ref ans i) left-sum-dist))
        (let* ([new-left-count (if (char=? (string-ref boxes i) #\1)
                                   (add1 left-count)
                                   left-count)]
               [new-left-sum-dist (+ left-sum-dist new-left-count)])
          (loop-left (add1 i) new-left-count new-left-sum-dist))))

    ;; Second pass: calculate cost from balls to the right
    (let loop-right ([i (- n 1)]
                     [right-count 0]
                     [right-sum-dist 0])
      (when (>= i 0)
        (vector-set! ans i (+ (vector-ref ans i) right-sum-dist))
        (let* ([new-right-count (if (char=? (string-ref boxes i) #\1)
                                    (add1 right-count)
                                    right-count)]
               [new-right-sum-dist (+ right-sum-dist new-right-count)])
          (loop-right (sub1 i) new-right-count new-right-sum-dist))))

    (vector->list ans)))