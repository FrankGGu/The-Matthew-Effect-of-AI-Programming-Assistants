#lang racket

(define (num-ways n)
  (define (factor-count x)
    (let loop ([i 2] [count 0])
      (cond [(> i (sqrt x)) count]
            [(= (modulo x i) 0)
             (if (= i (/ x i))
                 (+ count 1)
                 (+ count 2))]
            [else (loop (+ i 1) count)])))

  (define (comb k)
    (if (= k 0) 1
        (* k (comb (- k 1)))))

  (define (pow x y)
    (if (= y 0) 1
        (* x (pow x (- y 1)))))

  (define (count-divisors x)
    (let loop ([i 2] [res 0])
      (cond [(> i (sqrt x)) res]
            [(= (modulo x i) 0)
             (if (= i (/ x i))
                 (+ res 1)
                 (+ res 2))]
            [else (loop (+ i 1) res)])))

  (define (solve n)
    (let ([d (count-divisors n)])
      (if (= d 0) 0
          (pow 2 (- d 1)))))

  (solve n))