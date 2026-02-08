(define/contract (max-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [count 0])
    (if (< (length nums) 2)
        count
        (let ([sum (+ (first nums) (second nums))])
          (let ([new-count (count-same-sum nums sum 0)])
          (if (> new-count count)
              (loop (cdr nums) new-count)
              (loop (cdr nums) count))))))

(define/contract (count-same-sum nums sum count)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (if (< (length nums) 2)
      count
      (if (= (+ (first nums) (second nums)) sum)
          (count-same-sum (cddr nums) sum (add1 count))
          count)))