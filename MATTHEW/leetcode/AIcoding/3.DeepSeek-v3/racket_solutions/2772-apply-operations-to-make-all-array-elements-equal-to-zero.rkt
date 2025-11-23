(define (check-array nums k)
  (let loop ((i 0) (n (length nums)) (diff 0))
    (cond
      [(>= i n) (zero? diff)]
      [(< i (- n k 1))
       (let ((current (+ (list-ref nums i) diff)))
         (if (< current 0)
             #f
             (loop (+ i 1) n (- current))))]
      [else
       (let ((current (+ (list-ref nums i) diff)))
         (if (not (= current 0))
             #f
             (loop (+ i 1) n 0)))])))