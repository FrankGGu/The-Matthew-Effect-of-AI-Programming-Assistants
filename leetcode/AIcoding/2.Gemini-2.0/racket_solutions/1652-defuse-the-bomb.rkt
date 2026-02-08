(define (decrypt code k)
  (let* ((n (length code)))
    (cond
      [(zero? k) (make-list n 0)]
      [(positive? k)
       (let loop ((i 0) (result '()))
         (if (= i n)
             (reverse result)
             (let* ((sum (for/sum ((j (in-range 1 (+ k 1))))
                            (list-ref code (modulo (+ i j) n)))))
               (loop (+ i 1) (cons sum result)))))
       ]
      [else
       (let loop ((i 0) (result '()))
         (if (= i n)
             (reverse result)
             (let* ((sum (for/sum ((j (in-range 1 (+ (abs k) 1))))
                            (list-ref code (modulo (+ i (- j)) n)))))
               (loop (+ i 1) (cons sum result)))))
       ])))