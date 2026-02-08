#lang racket

(define (maximumRows mat cols)
  (define (count-rows-covered mask)
    (for/sum ([i (in-range (length mat))])
      (if (and (not (= (vector-ref mask i) #f))
               (for/or ([j (in-range (length (vector-ref mat i)))])
                 (and (= (vector-ref (vector-ref mat i) j) 1)
                      (= (vector-ref mask j) #t))))
        1
        0)))

  (define (backtrack start mask)
    (if (= (length mask) cols)
      (count-rows-covered mask)
      (for/max ([i (in-range start (length (vector-ref mat 0)))])
        (let ([new-mask (vector-set! (vector-copy mask) i #t)])
          (max (backtrack (add1 i) new-mask)
               (backtrack (add1 i) mask))))))

  (backtrack 0 (make-vector (length (vector-ref mat 0)) #f)))

(define (max-rows mat cols)
  (maximumRows mat cols))