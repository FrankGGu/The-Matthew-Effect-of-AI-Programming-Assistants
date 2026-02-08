(define (zigzag-convert s num-rows)
  (let* ([n (string-length s)])
    (cond
      [(= num-rows 1) s]
      [else
       (let ([rows (make-vector num-rows '())])
         (let loop ([i 0] [current-row 0] [going-down #t])
           (when (< i n)
             (vector-set! rows current-row
                          (append (vector-ref rows current-row)
                                  (list (string-ref s i))))

             (if going-down
                 (if (= current-row (- num-rows 1))
                     (loop (+ i 1) (- current-row 1) #f)
                     (loop (+ i 1) (+ current-row 1) #t))
                 (if (= current-row 0)
                     (loop (+ i 1) (+ current-row 1) #t)
                     (loop (+ i 1) (- current-row 1) #f))))))
         (list->string (apply append (vector->list rows)))))]))