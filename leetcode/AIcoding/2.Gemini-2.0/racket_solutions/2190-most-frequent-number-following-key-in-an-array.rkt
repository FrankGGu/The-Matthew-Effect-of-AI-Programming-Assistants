(define (most-frequent-number-following-key nums key)
  (define counts (make-hash))
  (define (helper nums key)
    (cond
      [(null? nums) (void)]
      [(and (not (null? (cdr nums))) (equal? (car nums) key))
       (let ((next-num (cadr nums)))
         (hash-update! counts next-num (λ (v) (+ v 1)) 0))]
      [else (helper (cdr nums) key)]))
  (helper nums key)
  (let loop ([keys (hash-keys counts)]
             [max-key #f]
             [max-count 0])
    (cond
      [(null? keys) max-key]
      [else (let ([curr-key (car keys)]
                   [curr-count (hash-ref counts curr-key)])
              (if (> curr-count max-count)
                  (loop (cdr keys) curr-key curr-count)
                  (loop (cdr keys) max-key max-count)))])))