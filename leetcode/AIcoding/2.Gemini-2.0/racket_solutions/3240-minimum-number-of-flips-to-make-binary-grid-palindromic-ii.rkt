(define (minFlips grid)
  (define n (vector-length grid))
  (define m (vector-length (vector-ref grid 0)))

  (define (is-palindrome? g)
    (for*/and ([i (in-range n)]
               [j (in-range (/ m 2))])
      (= (vector-ref (vector-ref g i) j)
         (vector-ref (vector-ref g i) (- m j 1)))))

  (define (flip g i j)
    (define new-g (copy g))
    (vector-set! (vector-ref new-g i) j (if (= (vector-ref (vector-ref g i) j) 0) 1 0))
    new-g)

  (define (solve g visited)
    (cond
      [(is-palindrome? g) 0]
      [(hash-has-key? visited g) #f]
      [else
       (hash-set! visited g #t)
       (let loop ([i 0] [j 0] [min-flips #f])
         (cond
           [(>= i n) min-flips]
           [(>= j m) (loop (+ i 1) 0 min-flips)]
           [else
            (let ([flipped-grid (flip g i j)])
              (let ([flips (solve flipped-grid visited)])
                (loop i (+ j 1)
                      (if flips
                          (cond
                            [(not min-flips) (+ flips 1)]
                            [(< (+ flips 1) min-flips) (+ flips 1)]
                            [else min-flips])
                          min-flips))))]))]))

  (let ([visited (make-hash)])
    (let ([result (solve grid visited)])
      (if result result -1))))