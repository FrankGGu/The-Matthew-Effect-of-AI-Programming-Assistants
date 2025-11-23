(define (count-good-triplets arr a b c)
  (define n (length arr))
  (define count 0)
  (for* ([i (in-range 0 n)]
         [j (in-range (+ i 1) n)]
         [k (in-range (+ j 1) n)])
    (when (and (<= (abs (- (list-ref arr i) (list-ref arr j))) a)
               (<= (abs (- (list-ref arr j) (list-ref arr k))) b)
               (<= (abs (- (list-ref arr i) (list-ref arr k))) c))
      (set! count (+ count 1))))
  count)