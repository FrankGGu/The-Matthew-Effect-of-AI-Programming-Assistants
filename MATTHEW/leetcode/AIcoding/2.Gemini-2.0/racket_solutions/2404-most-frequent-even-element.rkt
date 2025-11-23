(define (most-frequent-even element)
  (let* ([evens (filter even? element)]
         [counts (hash)])
    (for ([n evens])
      (hash-update! counts n (λ (v) (+ v 1)) 1))
    (if (hash-empty? counts)
        -1
        (let loop ([keys (hash-keys counts)] [max-key #f] [max-count 0])
          (cond
            [(null? keys)
             (if max-key max-key -1)]
            [else
             (let ([key (car keys)] [count (hash-ref counts key)])
               (if (> count max-count)
                   (loop (cdr keys) key count)
                   (if (= count max-count)
                       (loop (cdr keys) (min key max-key) count)
                       (loop (cdr keys) max-key max-count))))))))))