(define (can-construct ransom-note magazine)
  (define (char-counts str)
    (define (update-counts counts char)
      (hash-set counts char (+ 1 (hash-ref counts char 0))))
    (foldl update-counts (make-hash) (string->list str)))

  (define ransom-counts (char-counts ransom-note))
  (define magazine-counts (char-counts magazine))

  (define (check-chars chars)
    (cond
      [(empty? chars) #t]
      [else
       (let* ([char (car chars)]
              [ransom-count (hash-ref ransom-counts char 0)]
              [magazine-count (hash-ref magazine-counts char 0)])
         (if (>= magazine-count ransom-count)
             (check-chars (cdr chars))
             #f))]))

  (check-chars (remove-duplicates (string->list ransom-note))))