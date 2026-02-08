(define/contract (make-similar nums target)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([odd-nums (filter odd? nums)]
         [even-nums (filter even? nums)]
         [odd-target (filter odd? target)]
         [even-target (filter even? target)]
         [sorted-odd-nums (sort odd-nums <)]
         [sorted-even-nums (sort even-nums <)]
         [sorted-odd-target (sort odd-target <)]
         [sorted-even-target (sort even-target <)]
         [diff-odd (map - sorted-odd-nums sorted-odd-target)]
         [diff-even (map - sorted-even-nums sorted-even-target)]
         [pos-odd (filter positive? diff-odd)]
         [pos-even (filter positive? diff-even)])
    (quotient (+ (apply + pos-odd) 2) (apply + pos-even) 2)))