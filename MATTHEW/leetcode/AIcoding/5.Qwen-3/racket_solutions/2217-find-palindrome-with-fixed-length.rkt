#lang racket

(define (palindrome n k)
  (define (make-palindrome s)
    (string-append s (substring s 0 (if (even? n) (- n 1) (- n 2))) (reverse s)))
  (define (generate-prefix)
    (define prefix-len (quotient n 2))
    (define start (expt 10 (sub1 prefix-len)))
    (define end (expt 10 prefix-len))
    (for/list ([i (in-range start end)])
      (number->string i)))
  (define prefixes (generate-prefix))
  (for*/first ([p prefixes]
                [s (in-range 0 10)]
                #:when (<= (+ (string-length p) (if (even? n) 0 1)) n))
    (define s-str (number->string s))
    (define half (if (even? n) p (string-append p s-str)))
    (define full (string-append half (reverse half)))
    (if (= (string-length full) n) full #f)))

(define (digits x)
  (string->list (number->string x)))

(define (is-palindrome? s)
  (equal? s (reverse s)))

(define (find-palindrome n k)
  (define (helper i)
    (cond [(> i k) #f]
          [(and (even? n) (is-palindrome? (digits i))) i]
          [(and (odd? n) (is-palindrome? (digits i))) i]
          [else (helper (add1 i))]))
  (helper (expt 10 (sub1 n))))

(define (solve)
  (define n (read))
  (define k (read))
  (displayln (find-palindrome n k)))

(solve)