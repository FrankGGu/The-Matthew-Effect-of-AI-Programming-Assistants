(define/contract (get-hint secret guess)
  (-> string? string? string?)
  (let ([secret-list (string->list secret)]
        [guess-list (string->list guess)]
        [bulls 0]
        [cows 0]
        [secret-count (make-hash)]
        [guess-count (make-hash)])
    (for ([s secret-list] [g guess-list])
      (if (char=? s g)
          (set! bulls (add1 bulls))
          (begin
            (hash-update! secret-count s add1 0)
            (hash-update! guess-count g add1 0))))
    (for ([(k v) (in-hash secret-count)])
      (set! cows (+ cows (min v (hash-ref guess-count k 0))))
    (format "~aA~aB" bulls cows)))