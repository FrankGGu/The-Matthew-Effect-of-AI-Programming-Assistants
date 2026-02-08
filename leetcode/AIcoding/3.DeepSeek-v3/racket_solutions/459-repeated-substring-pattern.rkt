(define/contract (repeated-substring-pattern s)
  (-> string? boolean?)
  (let* ([n (string-length s)]
         [ss (string-append s s)])
    (string-contains? (substring ss 1 (- (* 2 n) 1)) s)))