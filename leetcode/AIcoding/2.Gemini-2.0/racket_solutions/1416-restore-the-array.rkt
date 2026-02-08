(define (number-of-arrays s k)
  (define n (string-length s))
  (define dp (make-vector (add1 n) 0))
  (vector-set! dp n 1)
  (define MOD 1000000007)

  (for ((i (in-range (sub1 n) -1 -1)))
    (when (char=? (string-ref s i) #\0)
      (continue))

    (define num 0)
    (for ((j (in-range i n)))
      (set! num (+ (* num 10) (- (char->integer (string-ref s j)) (char->integer #\0))))
      (when (> num k)
        (break))
      (set! (vector-ref dp i) (modulo (+ (vector-ref dp i) (vector-ref dp (add1 j))) MOD))))

  (vector-ref dp 0))