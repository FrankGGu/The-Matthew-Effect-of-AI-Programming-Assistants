#lang racket

(define (magic-permutation nums)
  (define n (length nums))
  (define visited (make-vector n #f))

  (define (backtrack current-len last-val)
    (if (= current-len n)
        #t
        (let loop ([i 0])
          (cond
            [(= i n) #f]
            [(vector-ref visited i) (loop (+ i 1))]
            [else
             (let ([current-val (list-ref nums i)])
               (if (or (= current-len 0)
                       (or (zero? (remainder current-val last-val))
                           (zero? (remainder last-val current-val))))
                   (begin
                     (vector-set! visited i #t)
                     (if (backtrack (+ current-len 1) current-val)
                         #t
                         (begin
                           (vector-set! visited i #f)
                           (loop (+ i 1)))))
                   (loop (+ i 1)))))])))

  (backtrack 0 0))