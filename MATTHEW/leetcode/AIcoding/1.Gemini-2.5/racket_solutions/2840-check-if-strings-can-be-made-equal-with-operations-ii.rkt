(define (check-if-strings-can-be-made-equal-with-operations-ii s1 s2)
  (let* ((n (string-length s1))
         (s1-chars (string->list s1))
         (s2-chars (string->list s2)))

    (define (get-chars-by-parity chars start-index)
      (let loop ((i start-index)
                 (acc '()))
        (if (>= i n)
            (reverse acc)
            (loop (+ i 2) (cons (list-ref chars i) acc)))))

    (let* ((s1-even-chars (get-chars-by-parity s1-chars 0))
           (s2-even-chars (get-chars-by-parity s2-chars 0))
           (s1-odd-chars (get-chars-by-parity s1-chars 1))
           (s2-odd-chars (get-chars-by-parity s2-chars 1)))

      (and (equal? (sort s1-even-chars char<?) (sort s2-even-chars char<?))
           (equal? (sort s1-odd-chars char<?) (sort s2-odd-chars char<?))))))