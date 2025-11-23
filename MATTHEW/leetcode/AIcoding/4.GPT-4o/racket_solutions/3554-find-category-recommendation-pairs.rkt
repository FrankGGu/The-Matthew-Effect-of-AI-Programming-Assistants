(define (recommended-pairs categories user1 user2)
  (define (count-pairs lst)
    (foldl (lambda (cat acc)
             (hash-update! acc cat (lambda (x) (+ x 1)) 0))
             ) (make-hash) lst))

  (define counts1 (count-pairs (hash-ref categories user1)))
  (define counts2 (count-pairs (hash-ref categories user2)))

  (define (pair-counts counts1 counts2)
    (for/list ([cat (hash-keys counts1)])
      (when (hash-has? counts2 cat)
        (list cat (*
                     (hash-ref counts1 cat)
                     (hash-ref counts2 cat))))))

  (define pairs (pair-counts counts1 counts2))
  (sort (filter (lambda (x) (> (second x) 0)) pairs)
        (lambda (x y) (> (second x) (second y)))))