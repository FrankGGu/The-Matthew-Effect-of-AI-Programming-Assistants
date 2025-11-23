(define (is-beautiful? s)
  (define (power-of-5? n)
    (cond
      [(< n 1) #f]
      [(= n 1) #t]
      [(zero? (modulo n 5)) (power-of-5? (quotient n 5))]
      [else #f]))
  (and (not (string=? s ""))
       (not (char=? (string-ref s 0) #\0))
       (power-of-5? (string->number (string-append "#b" s)))))

(define (min-beautiful-substrings s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) #f))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ i 1))])
      (define sub (substring s (- i j) i))
      (when (and (vector-ref dp (- i j)) (is-beautiful? sub))
        (cond
          [(not (vector-ref dp i)) (vector-set! dp i (+ 1 (vector-ref dp (- i j))))]
          [else (vector-set! dp i (min (vector-ref dp i) (+ 1 (vector-ref dp (- i j)))))]))))
  (if (vector-ref dp n) (vector-ref dp n) -1))