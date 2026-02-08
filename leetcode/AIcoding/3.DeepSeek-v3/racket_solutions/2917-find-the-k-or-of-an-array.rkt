(define (find-k-or nums k)
  (define (bit-at-pos n pos)
    (bitwise-and (arithmetic-shift n (- pos)) 1))

  (define (count-ones-at-pos pos)
    (for/sum ([num nums])
      (bit-at-pos num pos)))

  (let loop ([pos 0] [result 0])
    (if (>= pos 31)
        result
        (let ([ones (count-ones-at-pos pos)])
          (loop (add1 pos)
                (if (>= ones k)
                    (bitwise-ior result (arithmetic-shift 1 pos))
                    result))))))