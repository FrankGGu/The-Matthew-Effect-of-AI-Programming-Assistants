#lang racket

(define (find-length-of-longest-subarray-with-equal-0s-and-1s nums)
  (define count-map (make-hash))
  (hash-set! count-map 0 -1)
  (let loop ([i 0] [count 0] [max-len 0])
    (if (= i (length nums))
        max-len
        (let* ([num (list-ref nums i)]
               [count (if (= num 0) (- count 1) (+ count 1))])
          (if (hash-has-key? count-map count)
              (loop (+ i 1) count (max max-len (- i (hash-ref count-map count))))
              (begin
                (hash-set! count-map count i)
                (loop (+ i 1) count max-len)))))))

(define (main)
  (define input (read-line))
  (define nums (map string->number (string-split input)))
  (display (find-length-of-longest-subarray-with-equal-0s-and-1s nums)))

(main)