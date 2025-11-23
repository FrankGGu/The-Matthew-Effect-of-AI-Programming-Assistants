(define (atMostNGivenDigitSet digits n)
  (define n-str (number->string n))
  (define k (string-length n-str))
  (define ds (vectorize digits))

  (define (less-than-k)
    (let loop ([i 1] [acc 0])
      (if (> i k)
          acc
          (loop (+ i 1) (+ acc (* (expt (vector-length ds) i-1)
                                    (- (vector-length ds) 0)))))))

  (define (equal-to-k i strict?)
    (if (= i k)
        (if strict? 1 0)
        (let ([digit (string->number (substring n-str i (+ i 1)))])
          (let loop ([j 0] [acc 0] [found #f])
            (cond
              [(>= j (vector-length ds))
               (if found
                   acc
                   0)]
              [(<= (string->number (vector-ref ds j)) digit)
               (if (= (string->number (vector-ref ds j)) digit)
                   (loop (+ j 1) (+ acc (equal-to-k (+ i 1) strict?)) (or found #t))
                   (loop (+ j 1) (+ acc (expt (vector-length ds) (- k i 1))) found))]
              [else
               (loop (+ j 1) acc found)])))))

  (+ (less-than-k) (equal-to-k 0 #t)))