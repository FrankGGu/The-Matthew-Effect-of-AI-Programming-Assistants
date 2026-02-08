(define (find-maximum-xor nums)
  (let loop ([i 31] [mask 0] [max-xor 0])
    (if (< i 0)
        max-xor
        (let* ([mask (bitwise-ior mask (arithmetic-shift 1 i))]
               [prefixes (for/set ([num nums]) (bitwise-and num mask))]
               [temp (bitwise-ior max-xor (arithmetic-shift 1 i))]
               [found? (for/first ([p prefixes] 
                                 #:when (set-member? prefixes (bitwise-xor p temp)))
                         #t)])
          (loop (sub1 i) mask (if found? temp max-xor))))))