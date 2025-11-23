(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (gcd-sort arr)
  (define n (length arr))
  (define sorted-arr (sort arr <))
  (define (can-sort? x y)
    (and (member x sorted-arr)
         (member y sorted-arr)
         (not (= (gcd x y) 1)))
  )
  (define (check-sorted lst)
    (if (null? lst)
        #t
        (if (null? (cdr lst))
            #t
            (and (can-sort? (car lst) (cadr lst))
                 (check-sorted (cdr lst))))))
  (check-sorted arr))

(define (gcdSort arr)
  (if (gcd-sort arr)
      #t
      #f))