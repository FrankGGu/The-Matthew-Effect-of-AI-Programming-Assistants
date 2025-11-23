(define (stone-game-ix stones)
  (define (count x)
    (cond [(= x 0) 0]
          [(= x 1) 1]
          [else 2]))
  (define (mod x)
    (remainder x 3))
  (define cnt (make-vector 3 0))
  (for-each (lambda (x)
              (vector-set! cnt (mod x) (+ (vector-ref cnt (mod x)) 1)))
            stones)
  (let ([a (vector-ref cnt 1)]
        [b (vector-ref cnt 2)])
    (if (= a b)
        #f
        (if (< a b)
            (if (= (modulo (vector-ref cnt 0) 2) 1)
                #t
                #f)
            (if (= (modulo (vector-ref cnt 0) 2) 1)
                #f
                #t)))))