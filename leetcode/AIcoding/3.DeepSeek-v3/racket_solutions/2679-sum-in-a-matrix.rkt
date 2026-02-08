(define/contract (matrix-sum nums)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-rows (map (lambda (row) (sort row >)) nums)]
         [cols (apply map list sorted-rows)]
         [max-cols (map (lambda (col) (apply max col)) cols)])
    (apply + max-cols)))