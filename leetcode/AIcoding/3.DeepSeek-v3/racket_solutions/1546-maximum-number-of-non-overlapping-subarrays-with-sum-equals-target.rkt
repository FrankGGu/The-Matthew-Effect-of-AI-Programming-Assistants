(define/contract (max-non-overlapping-subarrays nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums]
             [sum 0]
             [seen (set 0)]
             [count 0])
    (if (null? nums)
        count
        (let* ([num (car nums)]
               [new-sum (+ sum num)]
               [required (- new-sum target)])
          (if (set-member? seen required)
              (loop '() 0 (set 0) (add1 count))
              (loop (cdr nums) new-sum (set-add seen new-sum) count)))))