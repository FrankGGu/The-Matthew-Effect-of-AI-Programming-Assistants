(define (query-kth-smallest-trimmed-number nums queries)
  (define (process-query k trim)
    (define indexed-trimmed-numbers
      (for/list ([num-str (in-list nums)]
                 [idx (in-naturals)])
        (let* ([len (string-length num-str)]
               [start-idx (max 0 (- len trim))]
               [trimmed-str (substring num-str start-idx len)]
               [trimmed-val (string->number trimmed-str)])
          (list trimmed-val idx))))

    (define sorted-numbers
      (sort indexed-trimmed-numbers
            (lambda (a b)
              (let ([val-a (first a)]
                    [idx-a (second a)]
                    [val-b (first b)]
                    [idx-b (second b)])
                (or (< val-a val-b)
                    (and (= val-a val-b) (< idx-a idx-b)))))))

    (second (list-ref sorted-numbers (- k 1))))

  (map (lambda (query)
         (process-query (first query) (second query)))
       queries))