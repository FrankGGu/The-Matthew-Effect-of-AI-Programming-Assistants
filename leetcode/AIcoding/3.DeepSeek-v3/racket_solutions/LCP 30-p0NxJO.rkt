(define/contract (magic-tower nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums]
             [hp 1]
             [heap (make-heap (lambda (a b) (< a b)))]
             [res 0])
    (cond
      [(empty? nums) res]
      [else
       (let* ([num (first nums)]
              [new-hp (+ hp num)])
         (if (>= new-hp 1)
             (loop (rest nums) new-hp (if (< num 0) (heap-add heap num) heap) res)
             (if (heap-empty? heap)
                 -1
                 (let ([min-num (heap-min heap)])
                   (heap-remove-min! heap)
                   (loop nums (+ (- hp min-num) num) heap (add1 res))))))]))