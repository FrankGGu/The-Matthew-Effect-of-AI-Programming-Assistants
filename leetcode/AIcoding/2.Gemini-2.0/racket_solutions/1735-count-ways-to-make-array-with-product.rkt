(define (count-ways queries n)
  (define mod 1000000007)
  (define (power base exp)
    (let loop ((b base) (e exp) (acc 1))
      (cond
        ((= e 0) acc)
        ((even? e) (loop (modulo (* b b) mod) (quotient e 2) acc))
        (else (loop (modulo (* b b) mod) (quotient e 2) (modulo (* acc b) mod))))))

  (define (mod-inv a m)
    (power a (- m 2)))

  (define (combinations n k)
    (if (or (< k 0) (> k n))
        0
        (let loop ((num 1) (den 1) (i 0))
          (if (= i k)
              (modulo (quotient num den) mod)
              (loop (modulo (* num (- n i)) mod) (modulo (* den (+ i 1)) mod) (+ i 1))))))

  (define (solve product)
    (if (= product 1)
        (combinations (+ n -1) (- 1))
        (let loop ((p product) (factors '()))
          (cond
            ((= p 1)
             (combinations (+ n (- (length factors))) (- (length factors))))
            (else
             (let ((smallest-factor (for/first ((i (in-range 2 (add1 (sqrt p))))
                                                 #:when (= (modulo p i) 0))
                                      i)))
               (if smallest-factor
                   (loop (quotient p smallest-factor) (cons smallest-factor factors))
                   (loop 1 (cons p factors)))))))))

  (map solve queries))