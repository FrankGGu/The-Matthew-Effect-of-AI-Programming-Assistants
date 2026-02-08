(define (find-maximum-xor nums)
  (let loop ([i 31] [mask 0] [max-xor 0])
    (if (< i 0)
        max-xor
        (let* ([mask (bitwise-ior mask (arithmetic-shift 1 i))]
               [prefixes (for/set ([num nums]) (bitwise-and num mask))])
          (let ([temp (bitwise-ior max-xor (arithmetic-shift 1 i))])
            (if (for/or ([prefix prefixes])
                  (set-member? prefixes (bitwise-xor temp prefix))
                (loop (sub1 i) mask temp)
                (loop (sub1 i) mask max-xor)))))))