(define/contract (length-of-longest-subsequence nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (letrec ([dp (lambda (i t)
                 (cond [(= t 0) 0]
                       [(or (< i 0) (= t 0)) 0]
                       [else
                        (let ([without (dp (- i 1) t)])
                          (if (>= t (list-ref nums i))
                              (max without (+ 1 (dp (- i 1) (- t (list-ref nums i)))))
                              without))]))])
    (dp (- (length nums) 1) target)))