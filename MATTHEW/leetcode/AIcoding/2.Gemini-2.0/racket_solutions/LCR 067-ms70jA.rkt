(define (find-maximum-xor nums)
  (define (bit-length n)
    (cond
      [(zero? n) 0]
      [else (+ 1 (bit-length (arithmetic-shift n -1)))]))

  (define (max-xor nums mask)
    (define prefix-set (make-hash))
    (for ([num nums])
      (hash-set! prefix-set (bitwise-and num mask) #t))

    (define (check-xor target)
      (for ([num nums])
        (define complement (bitwise-and (bitwise-xor num target) mask))
        (when (hash-has-key? prefix-set complement)
          (return #t))))

    (for/first ([bit (in-range (bit-length (apply max nums)) -1 -1)])
      (define new-target (bitwise-ior target (arithmetic-shift 1 bit)))
      (if (check-xor new-target)
          new-target
          target)))

  (max-xor nums 0))