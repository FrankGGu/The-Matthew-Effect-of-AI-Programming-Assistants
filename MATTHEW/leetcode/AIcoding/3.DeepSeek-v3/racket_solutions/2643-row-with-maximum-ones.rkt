(define/contract (row-and-maximum-ones mat)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (let loop ([rows mat]
             [max-ones -1]
             [max-row 0]
             [current-row 0])
    (cond
      [(null? rows) (list max-row max-ones)]
      [else
       (let ([ones (count (lambda (x) (= x 1)) (car rows))])
         (if (> ones max-ones)
             (loop (cdr rows) ones current-row (+ current-row 1))
             (loop (cdr rows) max-ones max-row (+ current-row 1))))])))