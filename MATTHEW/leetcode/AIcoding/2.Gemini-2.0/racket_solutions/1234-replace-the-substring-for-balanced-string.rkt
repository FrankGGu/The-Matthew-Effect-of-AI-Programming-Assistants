(define (balanced-string s)
  (define n (string-length s))
  (define k (/ n 4))
  (define counts (make-hash))
  (string-for-each (λ (c)
                      (hash-update! counts c (λ (v) (+ v 1)) 1))
                    s)
  (define (need c)
    (max 0 (- (hash-ref counts c 0) k)))
  (define (check)
    (and (<= (need #\Q) 0)
         (<= (need #\W) 0)
         (<= (need #\E) 0)
         (<= (need #\R) 0)))
  (if (check)
      0
      (let loop ([l 0] [r 0] [min-len n])
        (cond
          [(>= r n) min-len]
          [else
           (hash-update! counts (string-ref s r) (λ (v) (- v 1)))
           (let loop2 ([l l] [r r] [min-len min-len])
             (cond
               [(check)
                (let ([new-len (- r l 1)])
                  (hash-update! counts (string-ref s l) (λ (v) (+ v 1)))
                  (loop (+ l 1) r (min min-len new-len)))
               (>= l r) (loop (+ r 1) (+ r 1) min-len)
               (else
                (hash-update! counts (string-ref s l) (λ (v) (+ v 1)))
                (loop2 (+ l 1) r min-len)]))]
           )))))