(define (find-and-replace-in-string s indices sources targets)
  (define n (length indices))
  (define replacements (make-vector n #f))

  (for ([i (in-range n)])
    (let* ([start (vector-ref indices i)]
           [source (vector-ref sources i)]
           [target (vector-ref targets i)]
           [source-len (string-length source)])
      (when (and (string-prefix? source (substring s start (+ start source-len)))
                 (= (string-length (substring s start (+ start source-len))) source-len))
        (vector-set! replacements i target))))

  (define (replace-occurences s replacements)
    (define indices (list->vector (sort (map car (filter (lambda (x) (not (equal? (cdr x) #f))) (map-indexed (lambda (i v) (cons i (vector-ref replacements i))) (vector->list replacements))))
                                        (lambda (a b) (> a b)))))
    (define result (make-string (string-length s)))
    (define last-index 0)
    (for ([i (in-range (vector-length indices))])
      (let ([index (vector-ref indices i)])
        (set! result (string-append result (substring s last-index index)))
        (set! last-index (+ index (string-length (vector-ref replacements index)))))
      (set! result (string-append result (if (equal? (vector-ref replacements index) #f) "" (vector-ref replacements index)))))
    (set! result (string-append result (substring s last-index (string-length s))))
    result))

  (replace-occurences s replacements))