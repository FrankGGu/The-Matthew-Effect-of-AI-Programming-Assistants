(define/contract (length-of-lis nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([tails (make-vector (length nums) 0)]
        [size 0])
    (for ([num (in-list nums)])
      (let ([i (binary-search tails 0 size num)])
        (vector-set! tails i num)
        (if (= i size) (set! size (+ size 1)))))
    size))

(define (binary-search nums left right target)
  (let loop ([left left] [right right])
    (if (< left right)
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (vector-ref nums mid)])
          (if (< mid-val target)
              (loop (+ mid 1) right)
              (loop left mid)))
        left)))