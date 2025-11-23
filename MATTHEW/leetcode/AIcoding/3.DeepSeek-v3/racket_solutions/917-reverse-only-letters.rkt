(define/contract (reverse-only-letters s)
  (-> string? string?)
  (define lst (string->list s))
  (define (letter? c)
    (or (char<=? #\a c #\z) (char<=? #\A c #\Z)))
  (let loop ([left 0] [right (sub1 (length lst))])
    (cond
      [(>= left right) (list->string lst)]
      [(not (letter? (list-ref lst left))) (loop (add1 left) right)]
      [(not (letter? (list-ref lst right))) (loop left (sub1 right))]
      [else
       (let ([tmp (list-ref lst left)])
         (list-set! lst left (list-ref lst right))
         (list-set! lst right tmp)
         (loop (add1 left) (sub1 right))])))