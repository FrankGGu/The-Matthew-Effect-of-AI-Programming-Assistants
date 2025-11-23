(define (max-distance grid)
  (let* ([n (length grid)]
         [q (list)]
         [visited (make-mutable-vector (* n n) #f)])
    (for ([i (in-range n)]
          [j (in-range n)])
      (if (= (list-ref (list-ref grid i) j) 1)
          (begin
            (set! q (append q (list (list i j 0))))
            (vector-set! visited (+ (* i n) j) #t))))
    (if (null? q)
        -1
        (let loop ([q q] [max-dist -1])
          (if (null? q)
              max-dist
              (let* ([curr (car q)]
                     [i (list-ref curr 0)]
                     [j (list-ref curr 1)]
                     [dist (list-ref curr 2)])
                (let ([neighbors (list (list (- i 1) j)
                                      (list (+ i 1) j)
                                      (list i (- j 1))
                                      (list i (+ j 1)))])
                  (let* ([valid-neighbors
                           (filter (lambda (neighbor)
                                     (and (>= (list-ref neighbor 0) 0)
                                          (< (list-ref neighbor 0) n)
                                          (>= (list-ref neighbor 1) 0)
                                          (< (list-ref neighbor 1) n)
                                          (not (vector-ref! visited (+ (* (list-ref neighbor 0) n) (list-ref neighbor 1))))))
                                   neighbors)])
                    (for ([neighbor (in-list valid-neighbors)])
                      (vector-set! visited (+ (* (list-ref neighbor 0) n) (list-ref neighbor 1)) #t))
                    (loop (append (cdr q) (map (lambda (neighbor) (list (list-ref neighbor 0) (list-ref neighbor 1) (+ dist 1))) valid-neighbors))
                          (max max-dist dist)))))))))))