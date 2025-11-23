#lang racket

(define (largest-palindrome-divisible-by-k k)
  (define (is-palindrome? s)
    (equal? s (reverse s)))

  (define (generate-palindromes)
    (let loop ([n 1])
      (let ([s (number->string n)])
        (if (is-palindrome? s)
            (cons (string->number (string-append s (list->string (reverse (string->list s))))) (loop (+ n 1)))
            (loop (+ n 1)))))
    )

  (define (find-largest)
    (let ([palindromes (generate-palindromes)])
      (for/fold ([max-pal 0]) ([p palindromes])
        (if (and (> p max-pal) (= (modulo p k) 0))
            p
            max-pal))))

  (find-largest))

(define (main)
  (define k (read))
  (displayln (largest-palindrome-divisible-by-k k)))

(main)