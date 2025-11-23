(define/contract (max-min-sum nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (sliding-window op init)
    (let loop ([i 0] [j 0] [sum 0] [res init] [dq (make-deque)])
      (cond
        [(>= j (length nums)) res]
        [else
         (let ([num (list-ref nums j)])
           (set! sum (+ sum num))
           (while (and (not (deque-empty? dq)) (op num (list-ref nums (deque-back dq))))
             (deque-remove-back! dq))
           (deque-add-back! dq j)
           (if (>= (- j i) (sub1 k))
               (begin
                 (set! res (op res (list-ref nums (deque-front dq))))
                 (when (= i (deque-front dq)) (deque-remove-front! dq))
                 (set! sum (- sum (list-ref nums i)))
               (void))
           (loop (if (>= (- j i) (sub1 k)) (add1 i) i)
                 (add1 j)
                 sum
                 res
                 dq))])))
  (let ([max-sum (sliding-window max -inf.0)]
        [min-sum (sliding-window min +inf.0)])
    (+ max-sum min-sum)))