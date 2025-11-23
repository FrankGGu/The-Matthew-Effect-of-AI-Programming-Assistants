#lang racket

(define (is-palindrome s)
  (equal? s (reverse s)))

(define (min-cost-to-make-array-equalindromic nums)
  (define len (length nums))
  (define (get-palindromes n)
    (let loop ([i 0])
      (if (> i (* 1000000000 2))
          '()
          (let ([s (number->string i)])
            (if (is-palindrome s)
                (cons i (loop (+ i 1)))
                (loop (+ i 1)))))))

  (define (cost num pal)
    (abs (- num pal)))

  (define (find-min-cost nums)
    (for/fold ([min-cost +inf.0]) ([num nums])
      (min min-cost (apply + (map (lambda (pal) (cost num pal)) (get-palindromes num)))))
    )

  (find-min-cost nums))