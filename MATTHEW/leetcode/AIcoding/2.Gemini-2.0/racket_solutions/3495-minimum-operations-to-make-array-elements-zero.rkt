(define (minimum-operations nums)
  (let loop ([nums nums] [operations 0] [current-min 0])
    (cond
      [(empty? nums) operations]
      [else
       (let* ([non-zero-nums (filter (lambda (x) (> x 0)) nums)]
              [min-val (if (empty? non-zero-nums) 0 (apply min non-zero-nums))]
              [new-nums (map (lambda (x) (max 0 (- x min-val))) nums)])
         (if (= min-val 0)
             (loop (filter (lambda (x) (> x 0)) (cdr nums)) operations current-min)
             (loop new-nums (+ operations 1) min-val)))])))