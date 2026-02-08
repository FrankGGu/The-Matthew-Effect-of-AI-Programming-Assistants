(define (closest-dessert-cost base-costs topping-costs target)
  (define (abs-diff x) (abs (- x target)))

  (define (find-closest current-cost index)
    (cond
      [(>= index (length topping-costs)) current-cost]
      [else
       (let* ([cost1 (find-closest current-cost (add1 index))]
              [cost2 (find-closest (+ current-cost (list-ref topping-costs index)) (add1 index))]
              [cost3 (find-closest (+ current-cost (* 2 (list-ref topping-costs index))) (add1 index))]
              [diff1 (abs-diff cost1)]
              [diff2 (abs-diff cost2)]
              [diff3 (abs-diff cost3)])
         (cond
           [(and (<= diff1 diff2) (<= diff1 diff3)) cost1]
           [(and (<= diff2 diff1) (<= diff2 diff3))
            (if (= diff1 diff2) (min cost1 cost2) cost2)]
           [else
            (if (and (= diff1 diff3) (<= diff1 diff2)) (min cost1 cost3)
                (if (and (= diff2 diff3) (<= diff2 diff1)) (min cost2 cost3) cost3))]))]))

  (let ([closest (foldl (lambda (base-cost acc)
                           (let ([new-cost (find-closest base-cost 0)]
                                 [diff-acc (abs-diff acc)]
                                 [diff-new (abs-diff new-cost)])
                             (cond
                               [(< diff-new diff-acc) new-cost]
                               [(= diff-new diff-acc) (min new-cost acc)]
                               [else acc])))
                         (car base-costs)
                         (cdr base-costs))])
    closest))