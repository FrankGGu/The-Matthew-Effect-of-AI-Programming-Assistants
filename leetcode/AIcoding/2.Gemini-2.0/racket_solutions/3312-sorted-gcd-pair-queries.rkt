(define (sorted-gcd-pair-queries nums queries)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (find-pairs target)
    (let loop ([i 0] [j (sub1 (length nums))] [pairs '()])
      (if (>= i j)
          pairs
          (let ([g (gcd (list-ref nums i) (list-ref nums j))])
            (cond
              [(= g target) (loop (add1 i) (sub1 j) (cons (list (list-ref nums i) (list-ref nums j)) pairs))]
              [(< g target) (loop (add1 i) j pairs)]
              [else (loop i (sub1 j) pairs)])))))

  (define (process-query query)
    (let* ([l (car query)]
           [r (cadr query)]
           [sublist (sort (take (drop nums l) (- r l -1)) <)]
           [pairs (find-pairs (car (sort (list-copy sublist) >)))])
      (length pairs)))

  (map process-query queries))