(define (num-decodings s)
  (define n (string-length s))
  (define dp (make-vector (add1 n) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (add1 n))])
    (define one-digit (substring s (- i 1) i))
    (define two-digit (if (> i 1) (substring s (- i 2) i) #f))

    (define one-digit-ways
      (cond
        [(string=? one-digit "*") (modulo 9 (vector-ref dp (- i 1)))]
        [(and (string<=? "1" one-digit "9") (not (string=? one-digit "0"))) (vector-ref dp (- i 1))]
        [else 0]))

    (define two-digit-ways
      (cond
        [(not two-digit) 0]
        [(string=? two-digit "**") (modulo (* 15 (vector-ref dp (- i 2))) 1000000007)]
        [(string=? (substring two-digit 0 1) "*")
         (cond
           [(string<=? "0" (substring two-digit 1 2) "6") (modulo (* 2 (vector-ref dp (- i 2))) 1000000007)]
           [else (vector-ref dp (- i 2))])]
        [(string=? (substring two-digit 1 2) "*")
         (cond
           [(string=? (substring two-digit 0 1) "1") (modulo (* 9 (vector-ref dp (- i 2))) 1000000007)]
           [(string=? (substring two-digit 0 1) "2") (modulo (* 6 (vector-ref dp (- i 2))) 1000000007)]
           [else 0])]
        [(and (string<=? "10" two-digit "26") (not (string=? (substring two-digit 0 1) "0"))) (vector-ref dp (- i 2))]
        [else 0]))

    (vector-set! dp i (modulo (+ one-digit-ways two-digit-ways) 1000000007)))
  (vector-ref dp n))