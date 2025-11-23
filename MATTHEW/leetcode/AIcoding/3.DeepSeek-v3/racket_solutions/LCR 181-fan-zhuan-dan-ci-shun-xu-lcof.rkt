(define/contract (reverse-words s)
  (-> string? string?)
  (string-join (reverse (string-split s)) " "))