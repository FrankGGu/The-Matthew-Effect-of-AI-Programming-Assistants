(define (find-kth-largest-integer nums k)
  (let* ((numbers (map string->number nums))
         (sorted-numbers (sort numbers >)))
    (number->string (list-ref sorted-numbers (- k 1)))))