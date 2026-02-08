(define (prev-perm-opt1 arr)
  (let loop ((i (- (vector-length arr) 2)))
    (cond
      [(< i 0) arr]
      [(> (vector-ref arr i) (vector-ref arr (+ i 1)))
       (let ((j (- (vector-length arr) 1)))
         (let find-j ()
           (if (and (>= j 0) (>= (vector-ref arr j) (vector-ref arr i)))
               (begin
                 (set! j (- j 1))
                 (find-j))
               )
               (let ((temp (vector-ref arr i)))
                 (vector-set! arr i (vector-ref arr j))
                 (vector-set! arr j temp)
                 arr)
           )
         )
       )]
      [else (loop (- i 1))])))