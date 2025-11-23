(define (can-form-array arr pieces)
  (define hash (make-hash))
  (for ([piece pieces])
    (hash-set! hash (car piece) piece))
  (define (helper arr-idx)
    (cond
      [(>= arr-idx (length arr)) #t]
      [(not (hash-has-key? hash (list-ref arr arr-idx))) #f]
      [else
       (let ([piece (hash-ref hash (list-ref arr arr-idx))])
         (let loop ([piece-idx 0] [arr-idx arr-idx])
           (cond
             [(>= piece-idx (length piece)) (helper arr-idx)]
             [(= (list-ref piece piece-idx) (list-ref arr arr-idx))
              (loop (+ piece-idx 1) (+ arr-idx 1))]
             [else #f])))]))
  (helper 0))