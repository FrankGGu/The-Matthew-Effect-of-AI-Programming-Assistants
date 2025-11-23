(define (min-flips s)
  (let* ([n (string-length s)]
         [s (string-append s s)]
         [alt0 (make-string (string-length s))]
         [alt1 (make-string (string-length s))]
         [flip0 (make-vector (string-length s) 0)]
         [flip1 (make-vector (string-length s) 0)])
    (for ([i (in-range (string-length s))])
      (string-set! alt0 i (if (even? i) #\0 #\1))
      (string-set! alt1 i (if (even? i) #\1 #\0)))

    (for ([i (in-range (string-length s))])
      (vector-set! flip0 i (if (char=? (string-ref s i) (string-ref alt0 i))
                               (if (zero? i) 0 (vector-ref flip0 (- i 1)))
                               (if (zero? i) 1 (+ 1 (vector-ref flip0 (- i 1))))))
      (vector-set! flip1 i (if (char=? (string-ref s i) (string-ref alt1 i))
                               (if (zero? i) 0 (vector-ref flip1 (- i 1)))
                               (if (zero? i) 1 (+ 1 (vector-ref flip1 (- i 1)))))))

    (let loop ([i 0] [min-flips #f])
      (if (= i n)
          (or min-flips 0)
          (let ([curr-flips0 (- (vector-ref flip0 (+ i n -1)) (if (zero? i) 0 (vector-ref flip0 (- i 1)))))
                [curr-flips1 (- (vector-ref flip1 (+ i n -1)) (if (zero? i) 0 (vector-ref flip1 (- i 1)))))
                [curr-min (min curr-flips0 curr-flips1)])
            (loop (+ i 1) (if min-flips (min min-flips curr-min) curr-min)))))))