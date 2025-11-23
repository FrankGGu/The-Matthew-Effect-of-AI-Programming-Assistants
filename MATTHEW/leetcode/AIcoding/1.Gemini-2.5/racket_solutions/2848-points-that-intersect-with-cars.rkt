(define (count-points-that-intersect-with-cars cars)
  (define covered (make-vector 101 #f))

  (for-each (lambda (car)
              (define start (first car))
              (define end (second car))
              (for ([i (in-range start (+ end 1))])
                (vector-set! covered i #t)))
            cars)

  (for/sum ([i (in-range 1 101)]
            #:when (vector-ref covered i))
           1))