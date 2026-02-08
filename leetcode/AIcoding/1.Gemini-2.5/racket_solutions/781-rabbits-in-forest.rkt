(define (num-rabbits answers)
  (define counts (make-hash))

  (for-each
   (lambda (ans)
     (hash-set! counts ans (+ (hash-ref counts ans 0) 1)))
   answers)

  (define total-rabbits 0)

  (hash-for-each
   (lambda (ans count)
     (define x ans)
     (define k count)
     (define group-size (+ x 1))
     (define num-groups (ceiling (/ k group-size)))
     (set! total-rabbits (+ total-rabbits (* num-groups group-size))))
   counts)

  total-rabbits)