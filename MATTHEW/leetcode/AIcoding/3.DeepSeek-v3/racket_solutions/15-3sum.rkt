(define/contract (three-sum nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let loop ([nums (sort nums <)] [res '()])
    (if (< (length nums) 3)
        res
        (let* ([a (first nums)]
               [target (- 0 a)]
               [left (cdr nums)]
               [right (cdr (reverse nums))])
          (let inner ([left left] [right right] [res res])
            (cond
              [(>= (car left) (car right)) (loop (cdr nums) res)]
              [else
               (let ([sum (+ (car left) (car right))])
                 (cond
                   [(= sum target)
                    (inner (cdr left) (cdr right)
                           (cons (list a (car left) (car right)) res))]
                   [(< sum target) (inner (cdr left) right res)]
                   [else (inner left (cdr right) res)]))]))))))