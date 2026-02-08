(require racket/hash)
(require racket/set)

(define (unique-occurrences arr)
  (define counts (make-hash))

  (for-each (lambda (x)
              (hash-set! counts x (+ (hash-ref counts x 0) 1)))
            arr)

  (define occurrence-list (hash-values counts))
  (define occurrence-set (list->set occurrence-list))

  (= (length occurrence-list) (set-count occurrence-set)))