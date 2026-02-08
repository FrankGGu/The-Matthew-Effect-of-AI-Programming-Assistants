(define (frogJump stones)
  (define n (length stones))
  (define dp (make-vector n #f))
  (vector-set! dp 0 0)

  (define (jump i)
    (if (>= i n) #f)
    (if (vector-ref dp i)
        (vector-ref dp i)
        (let ((min-jumps +inf.0))
          (for ([j (in-range (+ 1 (if (>= i 1) (vector-ref stones (- i 1)) 0)))])
                #:when (and (>= j 0) (< j n) (<= (abs (- (vector-ref stones i) j)) 1)))
            (define next (jump j))
            (if next
                (set! min-jumps (min min-jumps (+ next 1))))
            )
          (vector-set! dp i min-jumps)
          min-jumps)))

  (jump (- n 1)))

(frogJump '(0 1 2 3 4 5 6 7 8 9 10))