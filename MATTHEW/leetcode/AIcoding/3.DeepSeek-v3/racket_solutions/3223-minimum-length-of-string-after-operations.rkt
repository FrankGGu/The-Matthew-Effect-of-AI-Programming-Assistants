(define/contract (minimum-length s)
  (-> string? exact-integer?)
  (let loop ([s (string->list s)])
    (if (or (null? s) (null? (cdr s)) (not (char=? (car s) (last s))))
        (length s)
        (let ([prefix (takef s (λ (c) (char=? c (car s))))]
              [suffix (takef-right s (λ (c) (char=? c (last s))))])
          (loop (drop-right (drop s (length prefix)) (length suffix))))))