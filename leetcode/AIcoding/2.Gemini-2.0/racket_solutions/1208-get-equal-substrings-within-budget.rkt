(define (equal-substrings s t k)
  (define (cost-diff i)
    (abs (- (char->integer (string-ref s i)) (char->integer (string-ref t i)))))

  (define (max-equal-substrings s t k)
    (let loop ([l 0] [r 0] [curr-cost 0] [max-len 0])
      (cond
        [(>= r (string-length s)) max-len]
        [else
         (let ([new-cost (+ curr-cost (cost-diff r))])
           (cond
             [(<= new-cost k)
              (loop l (+ 1 r) new-cost (max max-len (+ 1 (- r l))))]
             [(= l r)
              (loop (+ 1 l) (+ 1 r) 0 max-len)]
             [else
              (loop (+ 1 l) r (- new-cost (cost-diff l)) max-len)]))]))))

  (max-equal-substrings s t k))