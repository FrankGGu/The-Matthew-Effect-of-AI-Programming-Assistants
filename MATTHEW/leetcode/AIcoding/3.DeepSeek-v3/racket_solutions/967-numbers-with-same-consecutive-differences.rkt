(define (nums-same-consec-diff n k)
  (define (dfs num digits-remaining)
    (if (zero? digits-remaining)
        (list num)
        (let* ((last-digit (modulo num 10))
               (next-digits (remove-duplicates
                             (append
                              (if (>= (+ last-digit k) 0) (list (+ last-digit k)) '())
                              (if (< (- last-digit k) 10) (list (- last-digit k)) '()))))
               (valid-next-digits (filter (lambda (d) (and (>= d 0) (< d 10))) next-digits)))
          (apply append (map (lambda (d) (dfs (+ (* num 10) d) (- digits-remaining 1)) valid-next-digits)))))

  (if (= n 1)
      (range 0 10)
      (remove-duplicates (apply append (map (lambda (d) (dfs d (- n 1))) (range 1 10))))))