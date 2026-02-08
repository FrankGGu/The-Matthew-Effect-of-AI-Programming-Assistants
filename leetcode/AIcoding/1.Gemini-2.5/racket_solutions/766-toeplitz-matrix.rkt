(define (is-toeplitz-matrix matrix)
  (let* ([m (length matrix)]
         [n (if (null? matrix) 0 (length (car matrix)))])
    (if (or (= m 0) (= n 0))
        #t
        (let loop-rows ([r 0])
          (if (= r (- m 1))
              #t
              (let loop-cols ([c 0])
                (if (= c (- n 1))
                    (loop-rows (+ r 1))
                    (if (= (list-ref (list-ref matrix r) c)
                           (list-ref (list-ref matrix (+ r 1)) (+ c 1)))
                        (loop-cols (+ c 1))
                        #f))))))))