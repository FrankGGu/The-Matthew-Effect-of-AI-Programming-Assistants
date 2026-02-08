(define (nums-same-consec-diff n k)
  (define (helper digit remaining)
    (cond [(zero? remaining) (list digit)]
          [else
           (let ((next-digits (filter (lambda (d) (<= 0 d 9)) (list (+ digit k) (- digit k)))))
             (apply append (map (lambda (next-digit) (map (lambda (num) (+ (* 10 num) digit)) (helper next-digit (- remaining 1)))) next-digits)))]))
  (let ((first-digits (filter (lambda (d) (not (zero? d))) (range 1 10))))
    (remove-duplicates (apply append (map (lambda (digit) (helper digit (- n 1))) first-digits)))))