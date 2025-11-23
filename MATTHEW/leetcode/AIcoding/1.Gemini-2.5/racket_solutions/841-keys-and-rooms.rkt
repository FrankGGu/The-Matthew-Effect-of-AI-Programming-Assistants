(define (can-visit-all-rooms rooms)
  (define num-rooms (length rooms))
  (define visited (make-hash-set))

  (define (dfs current-room)
    (hash-set-add! visited current-room)
    (for ([key (list-ref rooms current-room)])
      (unless (hash-set-member? visited key)
        (dfs key))))

  (dfs 0)
  (equal? (hash-set-count visited) num-rooms))