(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [ops 0])
    (if (andmap zero? nums)
        ops
        (let* ([min-non-zero (apply min (filter positive? nums))]
               [new-nums (map (lambda (x) (if (positive? x) (- x min-non-zero) x)) nums)])
          (loop new-nums (+ ops min-non-zero))))))