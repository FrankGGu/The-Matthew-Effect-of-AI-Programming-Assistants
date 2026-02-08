(define/contract (detect-capital-use word)
  (-> string? boolean?)
  (let ([len (string-length word)])
    (cond
      [(= len 0) #t]
      [(= (string-length (string-upcase word)) len) #t]
      [(= (string-length (string-downcase word)) len) #t]
      [(and (char-upper-case? (string-ref word 0))
            (= (string-length (string-downcase (substring word 1))) (- len 1))] #t]
      [else #f])))