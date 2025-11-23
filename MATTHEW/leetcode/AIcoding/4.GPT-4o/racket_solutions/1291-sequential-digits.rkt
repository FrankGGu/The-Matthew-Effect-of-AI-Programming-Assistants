(define (sequential-digits low high)
  (define (generate-seq start end)
    (if (> start end) '()
        (cons start (generate-seq (+ start 1) end))))
  (define (to-seq n)
    (let loop ((current 0) (digit 1))
      (if (>= digit 10) current
          (loop (+ current (* 10 digit)) (+ digit 1)))))
  (define (filter-seq lst)
    (filter (lambda (x) (and (>= x low) (<= x high))) lst))

  (define seqs (generate-seq 12 123456789))
  (filter-seq (map to-seq seqs)))

(sequential-digits 100 300)