(define (sum-of-beauty nums)
  (let* ([n (vector-length nums)]
         [suffix-max (make-vector n 0)])

    ;; Calculate suffix maximums
    (vector-set! suffix-max (- n 1) (vector-ref nums (- n 1)))
    (for i (range (- n 2) -1 -1)
      (vector-set! suffix-max i (max (vector-ref nums i)
                                     (vector-ref suffix-max (+ i 1)))))

    ;; Calculate total beauty
    (for/fold ([total-beauty 0])
              ([i (range 1 (- n 1))])
      (let* ([left (vector-ref nums (- i 1))]
             [current (vector-ref nums i)]
             [right (vector-ref nums (+ i 1))])
        (cond
          [(and (< left current) (< current right))
           (+ total-beauty 2)]
          [(and (< left current) (> current (vector-ref suffix-max (+ i 1))))
           (+ total-beauty 1)]
          [else
           total-beauty])))))