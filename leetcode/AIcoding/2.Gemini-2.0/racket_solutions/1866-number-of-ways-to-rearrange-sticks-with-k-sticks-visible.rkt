(define (num-ways n k)
  (define memo (make-hash))
  (define (dp n k)
    (cond
      [(= k 0) (if (= n 0) 1 0)]
      [(or (< n 0) (< k 0)) 0]
      [(= n k) 1]
      [(hash-has-key? memo (cons n k)) (hash-ref memo (cons n k))]
      [else
       (let ([result (modulo (+ (dp (- n 1) (- k 1)) (* (- n 1) (dp (- n 1) k))) 1000000007)])
         (hash-set! memo (cons n k) result)
         result)]))
  (dp n k))