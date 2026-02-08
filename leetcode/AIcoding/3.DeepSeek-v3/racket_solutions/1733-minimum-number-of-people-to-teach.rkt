(define (minimum-teachings n languages friendships)
  (let* ([lang-set (make-hash)]
         [no-common-lang (filter (lambda (pair)
                                   (let ([a (car pair)]
                                         [b (cadr pair)])
                                     (empty? (set-intersect (list->set (list-ref languages (sub1 a)))
                                                           (list->set (list-ref languages (sub1 b))))))
                                 friendships)]
         [users (remove-duplicates (append-map (lambda (pair) pair) no-common-lang))]
         [user-count (length users)])
    (if (zero? user-count)
        0
        (let ([lang-count (make-hash)])
          (for ([user users])
            (for ([lang (list-ref languages (sub1 user))])
              (hash-update! lang-count lang add1 (lambda () 0))))
          (let ([max-lang-count (if (hash-empty? lang-count) 0 (apply max (hash-values lang-count)))])
            (- user-count max-lang-count))))))