(define (countDistinctIntegers nums)
  (define (reverse-number n)
    (string->number (string-reverse (number->string n))))
  (define distinct-numbers (make-hash))
  (for-each (lambda (n)
              (hash-set! distinct-numbers n)
              (hash-set! distinct-numbers (reverse-number n)))
            nums)
  (hash-count distinct-numbers))

(countDistinctIntegers '(1 2 3)) ; Change this to test with different inputs