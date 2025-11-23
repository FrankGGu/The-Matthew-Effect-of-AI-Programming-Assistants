#lang racket

(define (longest-mono-subarray nums)
  (define len (length nums))
  (if (= len 0) 0
      (let loop ([i 1] [max-len 1] [current-len 1] [prev (car nums)])
        (if (= i len)
            max-len
            (let ([curr (list-ref nums i)])
              (if (> curr prev)
                  (loop (+ i 1) (max max-len (+ current-len 1)) (+ current-len 1) curr)
                  (if (< curr prev)
                      (loop (+ i 1) (max max-len (+ current-len 1)) (+ current-len 1) curr)
                      (loop (+ i 1) (max max-len current-len) 1 curr))))))))

(define/contract (longest-mono-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (longest-mono-subarray nums))