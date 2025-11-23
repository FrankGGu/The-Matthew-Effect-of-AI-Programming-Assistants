(define (valid-mountain-array arr)
  (let* ((n (length arr))
         (i 0))
    (cond
      [(< n 3) #f]
      [else
       (begin
         ;; find peak
         (while (< i (- n 1))
           (if (> (list-ref arr i) (list-ref arr (+ i 1)))
               (break)
               (set! i (+ i 1))))

         (if (or (= i 0) (= i (- n 1)))
             #f
             (begin
               ;; check increasing part
               (let loop-up ((j 0))
                 (cond
                   [(>= j i) #t]
                   [else
                    (if (>= (list-ref arr j) (list-ref arr (+ j 1)))
                        #f
                        (loop-up (+ j 1))])))

               (and
                (not (or (= i 0) (= i (- n 1))))
                (let loop-down ((j i))
                  (cond
                    [(>= j (- n 1)) #t]
                    [else
                     (if (<= (list-ref arr j) (list-ref arr (+ j 1)))
                         #f
                         (loop-down (+ j 1)))])))))]))))