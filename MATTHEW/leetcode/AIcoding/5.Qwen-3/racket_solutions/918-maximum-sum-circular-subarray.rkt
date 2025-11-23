#lang racket

(define (max-subarray nums)
  (define len (length nums))
  (define (kadane arr)
    (let loop ([max-current (car arr)]
               [max-so-far (car arr)]
               [i 1])
      (if (= i len)
          max-so-far
          (loop (max (+ (list-ref arr i) max-current) (list-ref arr i))
                (max max-so-far (max (+ (list-ref arr i) max-current) (list-ref arr i)))
                (+ i 1)))))
  (define (max-circular)
    (let ([max-kadane (kadane nums)])
      (if (= max-kadane (apply min nums))
          max-kadane
          (let ([total-sum (apply + nums)]
                [min-kadane (kadane (map (lambda (x) (- x)) nums))])
            (max max-kadane (- total-sum min-kadane)))))
    )
  (max-circular))

(define/contract (max-subarray-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (max-subarray nums))