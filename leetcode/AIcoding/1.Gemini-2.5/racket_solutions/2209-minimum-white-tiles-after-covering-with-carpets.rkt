(define (minimum-white-tiles tiles num-carpets carpet-len)
  (define n (string-length tiles))

  (define prefix-white (make-vector (+ n 1) 0))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! prefix-white i
                 (+ (vector-ref prefix-white (- i 1))
                    (if (char=? (string-ref tiles (- i 1)) #\1) 1 0))))

  (define dp (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ num-carpets 1))))

  (for ([i (in-range (+ n 1))])
    (vector-set! (vector-ref dp i) 0 (vector-ref prefix-white i)))

  (for ([j (in-range 1 (+ num-carpets 1))])
    (vector-set! (vector-ref dp 0) j 0))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ num-carpets 1))])
      (define option1 (+ (vector-ref (vector-ref dp (- i 1)) j)
                         (if (char=? (string-ref tiles (- i 1)) #\1) 1 0)))

      (define k (max 0 (- i carpet-len)))
      (define option2 (vector-ref (vector-ref dp k) (- j 1)))

      (vector-set! (vector-ref dp i) j (min option1 option2))))

  (vector-ref (vector-ref dp n) num-carpets))