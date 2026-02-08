(define/contract (reverse-words s)
  (-> string? string?)
  (string-join
   (map (lambda (word) (list->string (reverse (string->list word))))
        (string-split s))
   " "))