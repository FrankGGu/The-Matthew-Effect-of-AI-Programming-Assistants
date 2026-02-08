(define (max-palindromes-after-operations s)
  (define counts (make-hash))
  (for ([c (string->list s)])
    (hash-update! counts c (lambda (v) (+ v 1)) 1))

  (define evens 0)
  (define odds 0)
  (for ([(k v) (in-hash counts)])
    (set! evens (+ evens (floor (/ v 2))))
    (set! odds (+ odds (modulo v 2))))

  (define n (string-length s))
  (define l (sort (map string-length (string-split s #" ")) <))

  (define ans 0)
  (for ([len l])
    (cond
      [(and (odd? len) (> odds 0))
       (set! odds (- odds 1))
       (set! evens (- evens (floor (/ len 2))))
       (if (>= evens 0)
           (set! ans (+ ans 1))
           (set! odds (+ odds 1))
           )
       ]
      [(even? len)
       (set! evens (- evens (floor (/ len 2))))
       (if (>= evens 0)
           (set! ans (+ ans 1))
           )]
      [else
       (void)
       ]))
  ans
  )