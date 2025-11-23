(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [res 0])
    (if (andmap zero? nums)
        res
        (let* ([non-zero (filter (lambda (x) (not (zero? x))) nums)]
               [min-val (apply min non-zero)]
               [new-nums (map (lambda (x) (if (zero? x) x (- x min-val))) nums)])
          (loop new-nums (+ res min-val))))))