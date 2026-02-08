(define (best-poker-hand ranks suits)
  ;; Helper to check if all suits are the same
  (define (all-same-suit? suits-list)
    (if (empty? suits-list)
        #t
        (let ([first-suit (car suits-list)])
          (andmap (lambda (s) (eq? s first-suit)) (cdr suits-list)))))

  ;; Check for Flush first
  (if (all-same-suit? suits)
      "Flush"
      ;; If not a Flush, check ranks
      (let* ([rank-counts (make-hash)]
             [_ (for-each (lambda (rank)
                            (hash-update! rank-counts rank add1 0))
                          ranks)]
             [counts (hash-values rank-counts)])
        (cond
          ;; Check for Three of a Kind
          [(member 3 counts) "Three of a Kind"]
          ;; Check for Pair
          [(member 2 counts) "Pair"]
          ;; Otherwise, it's High Card
          [else "High Card"]))))