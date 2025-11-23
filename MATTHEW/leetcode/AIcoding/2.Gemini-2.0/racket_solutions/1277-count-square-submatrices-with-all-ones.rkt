(define (count-squares matrix)
  (let* ((rows (length matrix))
         (cols (length (car matrix)))
         (dp (make-matrix rows cols 0)))
    (let loop ((i 0) (count 0))
      (if (= i rows)
          count
          (let loop2 ((j 0) (count count))
            (if (= j cols)
                (loop (+ i 1) count)
                (let ((val (list-ref (list-ref matrix i) j)))
                  (if (= val 0)
                      (begin
                        (matrix-set! dp i j 0)
                        (loop2 (+ j 1) count))
                      (let ((size (cond
                                     ((or (= i 0) (= j 0)) 1)
                                     (else
                                      (min (list-ref (list-ref dp (- i 1)) j)
                                           (list-ref (list-ref dp i) (- j 1))
                                           (list-ref (list-ref dp (- i 1)) (- j 1)))
                                      (+ 1)))))
                        (begin
                          (matrix-set! dp i j size)
                          (loop2 (+ j 1) (+ count size)))))))))))))