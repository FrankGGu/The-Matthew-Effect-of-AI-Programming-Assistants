(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [ops 0])
    (if (null? nums)
        ops
        (let* ([max-val (apply max nums)]
               [new-nums (map (lambda (x) (if (= x max-val) (- x 1) x)) nums)])
          (loop new-nums (+ ops 1))))))