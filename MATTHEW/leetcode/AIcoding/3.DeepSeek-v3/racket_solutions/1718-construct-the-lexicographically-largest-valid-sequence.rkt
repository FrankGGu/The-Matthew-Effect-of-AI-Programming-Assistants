(define (construct-distanced-sequence n)
  (define size (+ (* 2 n) -1))
  (define result (make-vector size 0))
  (define used (make-vector (+ n 1) #f))

  (define (backtrack pos)
    (cond
      [(= pos size) #t]
      [(not (zero? (vector-ref result pos))) (backtrack (+ pos 1))]
      [else
       (for ([num (in-range n 0 -1)])
         (cond
           [(and (not (vector-ref used num))
                 (or (= num 1)
                     (and (< (+ pos num) size)
                          (zero? (vector-ref result (+ pos num))))))
            (vector-set! used num #t)
            (vector-set! result pos num)
            (when (not (= num 1))
              (vector-set! result (+ pos num) num))
            (if (backtrack (+ pos 1))
                #t
                (begin
                  (vector-set! used num #f)
                  (vector-set! result pos 0)
                  (when (not (= num 1))
                    (vector-set! result (+ pos num) 0))))]
           [else #f]))]))

  (backtrack 0)
  (vector->list result))