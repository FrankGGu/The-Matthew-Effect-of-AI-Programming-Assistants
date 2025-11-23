#lang racket

(define (is-palindrome? n)
  (define s (number->string n))
  (equal? s (reverse (string->list s))))

(define (largest-palindrome-product n)
  (define max-val (expt 10 n))
  (define min-val (expt 10 (sub1 n)))
  (define start (sub1 max-val))
  (define end (quotient max-val 10))
  (define-values (max-palindrome _) 
    (for/fold ([max-pal 0]) ([i (in-range start end -1)])
      (for/fold ([current-max max-pal]) ([j (in-range i end -1)])
        (if (and (is-palindrome? (* i j)) (> (* i j) current-max))
            (* i j)
            current-max))))
  max-palindrome)

(define (main)
  (let ([n (read)])
    (printf "~a\n" (largest-palindrome-product n))))

(main)