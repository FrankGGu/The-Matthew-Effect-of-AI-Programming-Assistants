(define/contract (move-zeroes nums)
  (-> (listof exact-integer?) void?)
  (let loop ([nums nums] [non-zero '()] [zero-count 0])
    (cond
      [(null? nums)
       (set! nums (append non-zero (make-list zero-count 0)))]
      [(= (car nums) 0)
       (loop (cdr nums) non-zero (add1 zero-count))]
      [else
       (loop (cdr nums) (append non-zero (list (car nums))) zero-count])))