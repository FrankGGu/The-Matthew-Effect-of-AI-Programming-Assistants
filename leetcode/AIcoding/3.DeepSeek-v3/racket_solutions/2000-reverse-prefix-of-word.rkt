(define/contract (reverse-prefix word ch)
  (-> string? char? string?)
  (let ([idx (string-index word ch)])
    (if idx
        (string-append 
          (list->string (reverse (string->list (substring word 0 (add1 idx)))))
          (substring word (add1 idx)))
        word)))