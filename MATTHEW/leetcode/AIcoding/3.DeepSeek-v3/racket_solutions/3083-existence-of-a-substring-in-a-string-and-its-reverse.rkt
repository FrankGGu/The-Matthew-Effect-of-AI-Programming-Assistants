(define/contract (is-substring-present s)
  (-> string? boolean?)
  (let* ([n (string-length s)]
         [reversed-s (list->string (reverse (string->list s)))])
    (for/or ([i (in-range (- n 1))])
      (let ([sub (substring s i (+ i 2))])
        (string-contains? reversed-s sub)))))