(require racket/set)

(define (count-consistent-strings allowed words)
  (define allowed-set (list->set (string->list allowed)))

  (define (is-word-consistent? word)
    (for/all ((char (string->list word)))
      (set-member? allowed-set char)))

  (for/sum ((word words))
    (if (is-word-consistent? word) 1 0)))