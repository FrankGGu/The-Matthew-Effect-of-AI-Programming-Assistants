#lang racket

(define (diagonal-prime nums)
  (let* ((n (length nums))
         (max-p 0))

    (define (prime? num)
      (cond
        ((< num 2) #f)
        ((= num 2) #t)
        ((even? num) #f)
        (else
         (let loop ((i 3))
           (cond
             ((> (* i i) num) #t)
             ((zero? (remainder num i)) #f)
             (else (loop (+ i 2))))))))

    (for ([i (in-range n)])
      (let* ((val1 (list-ref (list-ref nums i) i))
             (val2 (list-ref (list-ref nums i) (- n 1 i))))
        (when (prime? val1)
          (set! max-p (max max-p val1)))
        (when (prime? val2)
          (set! max-p (max max-p val2)))))
    max-p))