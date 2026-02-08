(define (are-matrices-similar mat k)
  (let* ((m (length mat))
         (n (if (null? mat) 0 (length (car mat)))))

    (if (or (= m 0) (= n 0))
        #t

        (let ((actual-k (modulo k n)))
          (if (= actual-k 0)
              #t

              (let ((vec-mat (map list->vector mat)))
                (let loop-rows ((i 0))
                  (if (= i m)
                      #t

                      (let* ((current-row-vec (vector-ref vec-mat i)))
                        (let loop-cols ((j 0))
                          (if (= j n)
                              (loop-rows (+ i 1))

                              (let ((original-val (vector-ref current-row-vec j)))
                                (let ((val-from-shifted-pos
                                        (if (even? i)
                                            (vector-ref current-row-vec (modulo (- j actual-k) n))
                                            (vector-ref current-row-vec (modulo (+ j actual-k) n)))))

                                  (if (= original-val val-from-shifted-pos)
                                      (loop-cols (+ j 1))
                                      #f))))))))))))))