(define/contract (num-of-subarrays arr k threshold)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([left 0] [right (sub1 k)] [sum (apply + (take arr k))] [count 0])
    (cond
      [(>= right (length arr)) count]
      [else
       (let* ([new-count (if (>= (quotient sum k) threshold) (add1 count) count)]
         (if (>= (add1 right) (length arr))
             new-count
             (loop (add1 left) (add1 right) (+ sum (- (list-ref arr (add1 right)) (list-ref arr left)) new-count)))])))