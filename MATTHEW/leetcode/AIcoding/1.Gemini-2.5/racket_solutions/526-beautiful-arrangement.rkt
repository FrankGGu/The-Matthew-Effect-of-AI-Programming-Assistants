(define (count-arrangement n)
  (let ((used (make-vector (add1 n) #f)))
    (define (backtrack pos)
      (if (> pos n)
          1
          (let loop ((i 1) (current-count 0))
            (if (> i n)
                current-count
                (if (not (vector-ref used i))
                    (if (or (= (modulo i pos) 0)
                            (= (modulo pos i) 0))
                        (begin
                          (vector-set! used i #t)
                          (let ((res (backtrack (add1 pos))))
                            (vector-set! used i #f)
                            (loop (add1 i) (+ current-count res))))
                        (loop (add1 i) current-count))
                    (loop (add1 i) current-count))))))
    (backtrack 1)))