(define (can-make-all-elements-equal-to-zero nums k)
  (let* ([n (vector-length nums)]
         [applied-ops-at-idx (make-vector n 0)]
         [active-subtraction 0])
    (let loop ([i 0])
      (cond
        [(>= i n) #t]
        [else
         (when (>= i k)
           (set! active-subtraction (- active-subtraction (vector-ref applied-ops-at-idx (- i k)))))

         (let ([current-num (vector-ref nums i)])
           (let ([effective-num (- current-num active-subtraction)])
             (cond
               [(<= i (- n k))
                (cond
                  [(> effective-num 0)
                   (vector-set! applied-ops-at-idx i effective-num)
                   (set! active-subtraction (+ active-subtraction effective-num))
                   (loop (+ i 1))]
                  [(< effective-num 0) #f]
                  [else (loop (+ i 1))])]
               [else
                (if (= effective-num 0)
                    (loop (+ i 1))
                    #f)])))))))