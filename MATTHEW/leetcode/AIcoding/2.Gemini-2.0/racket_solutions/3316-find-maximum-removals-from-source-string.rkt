(define (maximum-removals source target)
  (define (check-removal removals)
    (define source-list (string->list source))
    (define target-list (string->list target))
    (define removals-set (list->set removals))

    (define filtered-source-list
      (filter (lambda (idx) (not (set-member? removals-set idx)))
              (range (string-length source))))

    (define filtered-source-string
      (list->string (map (lambda (idx) (list-ref source-list idx)) filtered-source-list)))

    (define (is-subsequence? s t)
      (cond
        [(empty? s) #t]
        [(empty? t) #f]
        [(= (first s) (first t)) (is-subsequence? (rest s) (rest t))]
        [else (is-subsequence? s (rest t))]))

    (is-subsequence? (string->list target) (string->list filtered-source-string)))

  (define (binary-search low high)
    (cond
      [(> low high) high]
      [else
       (let* ([mid (floor (/ (+ low high) 2))]
              [removals (take (in-range (length target-array)) (+ mid 1))]
              [target-array (string->list target)]
              [removals-list (map (lambda (i) (list-ref removals i)) (range 0 (length removals))))]
         (if (check-removal removals-list)
             (binary-search (+ mid 1) high)
             (binary-search low (- mid 1))))]))

  (define target-array (string->list target))

  (binary-search 0 (- (length target-array) 1)))