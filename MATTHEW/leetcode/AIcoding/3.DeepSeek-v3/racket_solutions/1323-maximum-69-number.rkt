(define (maximum69-number num)
  (let loop ((n num) (pos 1) (max-pos -1))
    (cond
      [(zero? n) (if (= max-pos -1) num (+ num (* 3 (expt 10 max-pos))))]
      [else
       (let ((digit (remainder n 10)))
         (if (= digit 6)
             (loop (quotient n 10) (+ pos 1) (- pos 1))
             (loop (quotient n 10) (+ pos 1) max-pos)))])))