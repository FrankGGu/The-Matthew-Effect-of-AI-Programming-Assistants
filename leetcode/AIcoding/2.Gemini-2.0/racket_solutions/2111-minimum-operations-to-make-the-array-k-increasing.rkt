(define (k-increasing arr k)
  (let ([n (length arr)])
    (letrec ([lis (λ (subarr)
                    (let ([tails (make-vector (length subarr) +inf.0)])
                      (for ([x subarr])
                        (let ([i (binary-search tails x)])
                          (vector-set! tails i x)))
                      (let loop ([i 0])
                        (cond
                          [(>= i (length tails)) 0]
                          [(equal? (vector-ref tails i) +inf.0) i]
                          [else (loop (+ i 1))]))))])
      (let loop ([i 0] [res 0])
        (cond
          [(>= i k) res]
          [else
           (let ([subarr (for/list ([j (in-range i n k)])
                           (list-ref arr j))])
             (loop (+ i 1) (+ res (- (length subarr) (lis subarr)))))])))))

(define (binary-search arr target)
  (let loop ([low 0] [high (- (vector-length arr) 1)])
    (cond
      [(> low high) low]
      [else
       (let ([mid (floor (/ (+ low high) 2))])
         (cond
           [(< (vector-ref arr mid) target) (loop (+ mid 1) high)]
           [else (loop low (- mid 1))]))])))