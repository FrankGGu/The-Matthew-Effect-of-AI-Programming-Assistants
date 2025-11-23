(define (check-if-can-be-equal s1 s2)
  (define (count-chars str)
    (let ((counts (make-hash)))
      (for ([c (in-string str)])
        (hash-update! counts c (λ (v) (+ v 1)) 1))
      counts))

  (define (compare-counts counts1 counts2)
    (andmap
     (λ (k)
       (equal? (hash-ref counts1 k 0) (hash-ref counts2 k 0)))
     (append (hash-keys counts1) (hash-keys counts2))))

  (define (sort-string str)
    (list->string (sort (string->list str) char<?)))

  (let* ((s1-even (sort-string (string-join (filter-map (λ (i) (if (even? i) (string (string-ref s1 i)) #f)) (range (string-length s1))) "")))
         (s2-even (sort-string (string-join (filter-map (λ (i) (if (even? i) (string (string-ref s2 i)) #f)) (range (string-length s2))) "")))
         (s1-odd (sort-string (string-join (filter-map (λ (i) (if (odd? i) (string (string-ref s1 i)) #f)) (range (string-length s1))) "")))
         (s2-odd (sort-string (string-join (filter-map (λ (i) (if (odd? i) (string (string-ref s2 i)) #f)) (range (string-length s2))) ""))))
    (and (equal? s1-even s2-even)
         (equal? s1-odd s2-odd))))