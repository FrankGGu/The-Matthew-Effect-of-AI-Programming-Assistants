#lang racket

(define (max-continuous-non-decreasing-length nums)
  (define len (length nums))
  (if (= len 0) 0
      (let loop ([i 1] [prev (car nums)] [max-len 1] [current-len 1])
        (if (= i len)
            max-len
            (let ([current (list-ref nums i)])
              (if (<= current prev)
                  (loop (+ i 1) current (max max-len current-len) 1)
                  (loop (+ i 1) current max-len (+ current-len 1))))))))