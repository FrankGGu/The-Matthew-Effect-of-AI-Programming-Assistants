(define/contract (find-subarrays nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 0] [sums (set)])
    (if (>= i (- (length nums) 1))
        #f
        (let ([current-sum (+ (list-ref nums i) (list-ref nums (+ i 1)))])
          (if (set-member? sums current-sum)
              #t
              (loop (+ i 1) (set-add sums current-sum)))))))