(define (maximum-or nums k)
  (let loop ([i 0]
             [max-or 0]
             [pre-or 0]
             [post-or (foldl bitwise-ior 0 (cdr nums))])
    (if (>= i (length nums))
        max-or
        (let* ([current (list-ref nums i)]
               [new-or (bitwise-ior pre-or post-or)]
               [new-val (arithmetic-shift current k)]
               [current-max (bitwise-ior new-or new-val)])
          (loop (add1 i)
                (max max-or current-max)
                (bitwise-ior pre-or current)
                (if (< (add1 i) (length nums))
                    (bitwise-ior post-or (list-ref nums (add1 i)))
                    post-or))))))