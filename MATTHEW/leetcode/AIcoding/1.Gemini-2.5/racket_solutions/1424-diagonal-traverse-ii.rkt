(define (find-diagonal-order nums)
  (define diagonals (make-hash))

  (for ([r (in-range (length nums))])
    (define row (list-ref nums r))
    (for ([c (in-range (length row))])
      (define val (list-ref row c))
      (define s (+ r c))
      (hash-set! diagonals s (cons val (hash-ref diagonals s '())))))

  (define sorted-sums (sort (hash-keys diagonals) <))

  (apply append (map (lambda (s) (hash-ref diagonals s)) sorted-sums)))