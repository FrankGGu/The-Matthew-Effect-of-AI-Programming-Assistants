(define (gem-replenishment jewels operations)
  (define current-jewels (list->vector jewels))

  (for-each (lambda (op)
              (define from-idx (car op))
              (define to-idx (cadr op))
              (define from-jewels (vector-ref current-jewels from-idx))
              (define num-to-move (floor (/ from-jewels 2)))

              (vector-set! current-jewels from-idx (- from-jewels num-to-move))
              (vector-set! current-jewels to-idx (+ (vector-ref current-jewels to-idx) num-to-move)))
            operations)

  (define final-jewels-list (vector->list current-jewels))
  (define max-jewels (apply max final-jewels-list))
  (define min-jewels (apply min final-jewels-list))

  (- max-jewels min-jewels))