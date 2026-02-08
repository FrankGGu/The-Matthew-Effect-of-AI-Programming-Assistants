(define (maximum-good statements)
  (define (valid? mask)
    (for*/[i (in-range (length statements))]
      (if (bitwise-and mask (bit-shift-left 1 i))
          (for*/[j (in-range (length statements))]
            (if (bitwise-and mask (bit-shift-left 1 j))
                (not (vector-ref (vector-ref statements i) j))))))
    #t)

  (define (count-good mask)
    (define count 0)
    (for*/[i (in-range (length statements))]
      (when (bitwise-and mask (bit-shift-left 1 i))
        (set! count (+ count 1))))
    count)

  (define max-good 0)
  (define n (length statements))
  (for*/[mask (in-range (bit-shift-left 1 n))]
    (when (valid? mask)
      (set! max-good (max max-good (count-good mask)))))
  max-good)

(maximum-good '((1 0) (1 1)))