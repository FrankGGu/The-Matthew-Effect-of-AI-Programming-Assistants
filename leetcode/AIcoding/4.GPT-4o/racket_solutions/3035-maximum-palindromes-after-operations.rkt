#lang racket

(define (maxPalindromes s k)
  (define len (string-length s))
  (define dp (make-vector (+ len 1) #f))
  (vector-set! dp 0 #t)

  (define (is-palindrome start end)
    (define substr (substring s start end))
    (equal? substr (string-reverse substr)))

  (define (count-palindromes start)
    (if (>= start len)
        0
        (let loop ((end start) (count 0))
          (if (>= end len)
              (loop (+ start 1) count)
              (if (and (is-palindrome start end) (>= (- end start) k))
                  (loop (+ start 1) (+ count 1))
                  (loop end count))))))

  (count-palindromes 0))

(maxPalindromes "abacc" 3)