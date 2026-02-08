(define (min-flips grid)
  (define (palindromic? g)
    (let loop ((i 0) (j (sub1 (length g))))
      (if (>= i j)
          #t
          (if (not (= (list-ref g i) (list-ref g j)))
              #f
              (loop (add1 i) (sub1 j))))))

  (define (count-flips g)
    (let* ((n (length g))
           (half-n (quotient n 2)))
      (for/sum ((i (in-range half-n)))
        (if (not (palindromic? (list-ref g i)))
            1
            0))))

  (define grid-flips (count-flips grid))
  (if (>= grid-flips 0)
      grid-flips
      -1))

(min-flips '((0 0 1) (1 0 0) (0 1 1)))