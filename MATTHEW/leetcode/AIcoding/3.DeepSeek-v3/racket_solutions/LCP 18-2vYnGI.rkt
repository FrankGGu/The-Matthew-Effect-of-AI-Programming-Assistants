(define/contract (breakfast-number staple drinks x)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (define mod 1000000007)
  (define (binary-search arr target)
    (let loop ([left 0] [right (sub1 (length arr))])
      (if (> left right)
          right
          (let* ([mid (quotient (+ left right) 2)]
                 [val (list-ref arr mid)])
            (if (<= val target)
                (loop (add1 mid) right)
                (loop left (sub1 mid))))))
  (let* ([sorted-staple (sort staple <)]
         [sorted-drinks (sort drinks <)]
         [n (length sorted-drinks)]
         [res 0])
    (for ([s (in-list sorted-staple)])
      (when (< s x)
        (let ([target (- x s)])
          (define idx (binary-search sorted-drinks target))
          (when (>= idx 0)
            (set! res (modulo (+ res (add1 idx)) mod))))))
    res))