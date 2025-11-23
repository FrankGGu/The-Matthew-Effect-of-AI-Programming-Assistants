(define/contract (closest-cost base-costs topping-costs target)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (define min-diff (make-parameter +inf.0))
  (define result (make-parameter 0))

  (define (dfs cost idx)
    (define current-diff (abs (- cost target)))
    (cond
      [(> current-diff (min-diff)) (void)]
      [(or (< current-diff (min-diff))
           (and (= current-diff (min-diff)) (< cost (result)))
       (min-diff current-diff)
       (result cost)]
      [else (void)])
    (when (and (< cost target) (< idx (length topping-costs)))
      (dfs cost (add1 idx))
      (dfs (+ cost (list-ref topping-costs idx)) (add1 idx))
      (dfs (+ cost (* 2 (list-ref topping-costs idx))) (add1 idx))))

  (for ([base base-costs])
    (dfs base 0))
  (result))