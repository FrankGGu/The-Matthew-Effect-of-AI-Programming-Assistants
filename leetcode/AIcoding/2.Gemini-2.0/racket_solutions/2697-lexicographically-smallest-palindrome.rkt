(define (make-smallest-palindrome s)
  (define n (string-length s))
  (define result (string-copy s))
  (for ([i (in-range (quotient n 2))])
    (let ([left (string-ref s i)]
          [right (string-ref s (- n i 1))])
      (cond
        [(char<? left right) (string-set! result (- n i 1) left)]
        [(char<? right left) (string-set! result i right)]
        [else #t])))
  result)