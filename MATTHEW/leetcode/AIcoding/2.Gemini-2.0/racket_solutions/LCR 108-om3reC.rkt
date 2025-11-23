(define (word-ladder begin-word end-word word-list)
  (define word-set (set word-list))
  (define q (queue))
  (queue-enqueue! q (cons begin-word 1))
  (define visited (make-hash))
  (hash-set! visited begin-word #t)

  (define (diff-by-one? w1 w2)
    (let ((diff-count 0))
      (for ((i (in-range (string-length w1))))
        (when (not (equal? (string-ref w1 i) (string-ref w2 i)))
          (set! diff-count (+ diff-count 1))))
      (= diff-count 1)))

  (let loop ()
    (if (queue-empty? q)
        0
        (let ((curr-node (queue-dequeue! q)))
          (let ((curr-word (car curr-node)) (curr-level (cdr curr-node)))
            (if (equal? curr-word end-word)
                curr-level
                (begin
                  (for ((word (in-list (set->list word-set))))
                    (when (and (diff-by-one? curr-word word)
                                (not (hash-has-key? visited word)))
                      (queue-enqueue! q (cons word (+ curr-level 1)))
                      (hash-set! visited word #t))))
                  (loop)))))))

  (if (set-member? word-set end-word)
      (word-ladder begin-word end-word word-list)
      0))