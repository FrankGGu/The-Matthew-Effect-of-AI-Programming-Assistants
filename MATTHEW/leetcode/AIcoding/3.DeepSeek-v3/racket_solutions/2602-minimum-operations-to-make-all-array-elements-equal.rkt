(define/contract (min-operations nums queries)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [prefix (make-vector (add1 n) 0)])
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (list-ref sorted-nums (sub1 i)))))
    (for/list ([q (in-list queries)])
      (let ([pos (binary-search sorted-nums q)])
        (let ([left-sum (+ (* q pos) (- (vector-ref prefix pos)))])
          [right-sum (- (* q (- n pos)) (- (vector-ref prefix n) (vector-ref prefix pos)))])
          (+ left-sum right-sum)))))

(define (binary-search nums target)
  (let loop ([left 0]
             [right (sub1 (length nums))])
    (if (> left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref nums mid)])
          (cond
            [(= mid-val target) mid]
            [(< mid-val target) (loop (add1 mid) right)]
            [else (loop left (sub1 mid))])))))