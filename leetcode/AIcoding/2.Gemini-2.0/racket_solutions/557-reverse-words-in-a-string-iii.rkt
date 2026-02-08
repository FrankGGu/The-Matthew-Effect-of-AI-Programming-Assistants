(define (reverse-words s)
  (string-join
   (map (λ (word) (list->string (reverse (string->list word))))
        (string-split s))
   " "))