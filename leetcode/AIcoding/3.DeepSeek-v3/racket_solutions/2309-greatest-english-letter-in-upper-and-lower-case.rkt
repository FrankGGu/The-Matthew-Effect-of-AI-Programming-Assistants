(define/contract (greatest-letter s)
  (-> string? string?)
  (let ([lower (make-hash)]
        [upper (make-hash)]
        [result ""])
    (for ([c s])
      (if (char-lower-case? c)
          (hash-set! lower (char-upcase c) #t)
          (hash-set! upper c #t)))
    (for ([c (in-string "ZYXWVUTSRQPONMLKJIHGFEDCBA")])
      (if (and (hash-has-key? upper c) (hash-has-key? lower c))
          (set! result (string c))
          (void)))
    result))