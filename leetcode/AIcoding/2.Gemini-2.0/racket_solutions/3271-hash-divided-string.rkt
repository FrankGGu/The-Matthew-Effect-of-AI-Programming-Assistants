(define (hash-divided-string s k)
  (let* ([n (string-length s)]
         [len (quotient n k)]
         [result '()])
    (if (zero? (remainder n k))
        (for ([i (in-range 0 n len)])
          (set! result (cons (substring s i (+ i len)) result))
          )
        (set! result '()))
    (reverse result)))