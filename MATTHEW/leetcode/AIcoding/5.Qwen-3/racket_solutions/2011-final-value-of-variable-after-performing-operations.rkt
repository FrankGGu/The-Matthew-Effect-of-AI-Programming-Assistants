(define (final-value-after-operations operations)
  (let loop ([ops operations] [val 0])
    (if (null? ops)
        val
        (loop (cdr ops) (+ val (if (or (string=? (car ops) "++X") (string=? (car ops) "X++")) 1 -1))))))