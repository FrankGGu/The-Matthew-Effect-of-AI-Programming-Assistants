(define (minimum-operations nums k)
  (let* ([n (length nums)]
         [less-k (filter (lambda (x) (< x k)) nums)]
         [equal-k (filter (lambda (x) (= x k)) nums)]
         [greater-k (filter (lambda (x) (> x k)) nums)]
         [less-len (length less-k)]
         [equal-len (length equal-k)]
         [greater-len (length greater-k)]
         [need-k (max 0 (- (ceiling (/ n 2.0)) equal-len))]
         [ops 0])
    (cond
      [(> (+ equal-len greater-len) (ceiling (/ n 2.0))) 0]
      [else
       (let* ([less-diffs (map (lambda (x) (- k x)) less-k)]
              [sorted-less-diffs (sort less-diffs <)])
         (apply + (take sorted-less-diffs need-k))))]))