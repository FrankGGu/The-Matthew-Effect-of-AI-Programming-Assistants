(define/contract (valid-palindrome s)
  (-> string? boolean?)
  (define (is-palindrome s left right)
    (let loop ([l left] [r right])
      (cond
        [(>= l r) #t]
        [(char=? (string-ref s l) (string-ref s r)) (loop (add1 l) (sub1 r))]
        [else #f])))
  (let loop ([left 0] [right (sub1 (string-length s))] [deleted #f])
    (cond
      [(>= left right) #t]
      [(char=? (string-ref s left) (string-ref s right)) (loop (add1 left) (sub1 right) deleted)]
      [deleted #f]
      [else (or (is-palindrome s (add1 left) right)
                (is-palindrome s left (sub1 right)))])))