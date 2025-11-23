(define (check-if-digits-are-equal-in-string-after-operations-ii s)
  (let* ([n (string-length s)]
         [counts (make-vector 10 0)])
    (for ([i (in-range n)])
      (let ([digit (string->number (substring s i (+ i 1)))])
        (vector-set! counts digit (+ (vector-ref counts digit) 1))))
    (let loop ([i 0])
      (cond
        [(= i 10) #t]
        [(> (vector-ref counts i) 0)
         (let loop2 ([j (+ i 1)])
           (cond
             [(= j 10) #t]
             [(> (vector-ref counts j) 0) #f]
             [else (loop2 (+ j 1))]))]
        [else (loop (+ i 1))]))))