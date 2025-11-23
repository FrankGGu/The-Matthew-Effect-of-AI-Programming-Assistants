(define/contract (find-unsorted-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length nums)]
         [left 0]
         [right (- n 1)])
    (let loop-left ([i 0])
      (if (and (< i n) (= (list-ref nums i) (list-ref sorted-nums i)))
          (loop-left (+ i 1))
          (set! left i)))
    (let loop-right ([i (- n 1)])
      (if (and (>= i 0) (= (list-ref nums i) (list-ref sorted-nums i)))
          (loop-right (- i 1))
          (set! right i)))
    (if (>= left right) 0 (+ (- right left) 1))))