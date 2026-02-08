(define (palindrome-partitioning-iv s)
  (define n (string-length s))
  (define (is-palindrome? start end)
    (let loop ([l start] [r end])
      (cond
        [(>= l r) #t]
        [(!= (string-ref s l) (string-ref s r)) #f]
        [else (loop (+ l 1) (- r 1))])))

  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 #t)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 0 i)])
      (when (and (vector-ref dp j) (is-palindrome? j (- i 1)))
        (vector-set! dp i #t))))

  (define dp2 (make-vector (+ n 1) #f))
  (vector-set! dp2 n #t)

  (for ([i (in-range (- n 1) -1 -1)])
    (for ([j (in-range (+ i 1) (+ n 1))])
      (when (and (vector-ref dp2 j) (is-palindrome? i (- j 1)))
        (vector-set! dp2 i #t))))

  (for ([i (in-range 1 (- n 1))])
    (for ([j (in-range (+ i 1) n)])
      (when (and (vector-ref dp i) (vector-ref dp2 j) (is-palindrome? i (- j 1)))
        (return #t))))

  #f)