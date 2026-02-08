(define (queries-permutation-with-key perm queries)
  (define (find-index key)
    (for/fold ([index -1]) ([i (in-range (length perm))])
      (if (equal? (list-ref perm i) key)
          (set! index i)))
    index)

  (define (process-query q)
    (let* ([index (find-index q)]
           [result (if (>= index 0) (list-ref perm index) -1)])
      (when (>= index 0)
        (set! perm (append (list-ref perm index) (list-ref perm (sub1 index)))))
      result))

  (map process-query queries))

(queries-permutation-with-key '(5 2 3 1 4) '(1 2 3))