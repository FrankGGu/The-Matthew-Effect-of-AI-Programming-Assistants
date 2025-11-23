#lang racket

(define (min-flips grid)
  (define (is-palindrome? row)
    (equal? row (reverse row)))

  (define (count-flips row)
    (for/sum ([i (in-range (quotient (length row) 2))])
      (if (= (list-ref row i) (list-ref row (- (length row) 1 i))) 0 1)))

  (define rows (map (lambda (s) (string->list s)) grid))
  (define cols (apply map list rows))

  (define row-palindromes (map is-palindrome? rows))
  (define col-palindromes (map is-palindrome? cols))

  (define row-flips (map count-flips rows))
  (define col-flips (map count-flips cols))

  (define row-total (apply + row-flips))
  (define col-total (apply + col-flips))

  (if (and (apply andmap row-palindromes) (apply andmap col-palindromes))
      0
      (min row-total col-total)))