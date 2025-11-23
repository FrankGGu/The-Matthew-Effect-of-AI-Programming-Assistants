#lang racket

(define (abbreviate-product left right)
  (define (product-range l r)
    (if (> l r)
        1
        (* l (product-range (+ l 1) r))))

  (define (count-trailing-zeros n)
    (if (= (modulo n 10) 0)
        (+ 1 (count-trailing-zeros (/ n 10)))
        0))

  (define (count-factors n factor)
    (if (< n factor)
        0
        (+ (quotient n factor) (count-factors (/ n factor) factor))))

  (define (get-nums l r)
    (for/list ([i (in-range l (+ r 1))])
      i))

  (define nums (get-nums left right))
  (define product (apply * nums))
  (define zeros (count-trailing-zeros product))
  (define twos (count-factors product 2))
  (define fives (count-factors product 5))

  (define (format-number n)
    (if (< n 1000000)
        (number->string n)
        (string-append (number->string (floor (/ n 1000000))) "e6")))

  (define (remove-trailing-zeros s)
    (let loop ([s s] [zeros zeros])
      (if (or (zero? zeros) (null? s))
          s
          (loop (cdr s) (- zeros 1)))))

  (define s (number->string product))
  (define s-without-zeros (remove-trailing-zeros s))
  (define prefix (substring s-without-zeros 0 (min 5 (string-length s-without-zeros))))
  (define suffix (substring s-without-zeros (- (string-length s-without-zeros) 5) (string-length s-without-zeros)))
  (define has-suffix (and (>= (string-length s-without-zeros) 5) (not (equal? prefix suffix))))

  (cond
    [(= zeros 0) (string-append prefix (if has-suffix (string-append "..." suffix) ""))]
    [else (string-append prefix (if has-suffix (string-append "..." suffix) "") "e" (number->string zeros))]))