(define (find-losers n k)
  (let ([received (make-vector n #f)])
    (let loop ([current-receiver 0]
               [round 1])
      (if (vector-ref received current-receiver)
          #f
          (begin
            (vector-set! received current-receiver #t)
            (let ([next-receiver (modulo (+ current-receiver (* round k)) n)])
              (loop next-receiver (add1 round))))))
    (for/list ([i (in-range n)]
               #:when (not (vector-ref received i)))
      i)))