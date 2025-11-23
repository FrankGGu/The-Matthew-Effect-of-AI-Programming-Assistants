(define/contract (min-increments n cost)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let loop ([i (sub1 n)] [res 0])
    (if (< i 0)
        res
        (let* ([left (if (< (add1 (* 2 i)) n) (list-ref cost (add1 (* 2 i))) 0)]
               [right (if (< (add1 (* 2 i 1)) n) (list-ref cost (add1 (* 2 i 1))) 0)]
               [max-child (max left right)])
          (begin
            (when (> i 0)
              (list-set! cost i (+ (list-ref cost i) max-child)))
            (loop (sub1 i) (+ res (abs (- left right)))))))))