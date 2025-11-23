#lang racket

(define (min-cost-to-equalize-array nums cost)
  (let* ([n (length nums)]
         [pairs (map cons nums cost)] ; Create a list of (num . cost) pairs
         [sorted-pairs (sort pairs (lambda (a b) (< (car a) (car b))))]
         [total-cost-sum (foldl (lambda (pair acc) (+ acc (cdr pair))) 0 sorted-pairs)]
         [target-x-val
          (let loop ([current-cost-sum 0]
                     [remaining-pairs sorted-pairs])
            (if (empty? remaining-pairs)
                ;; If the list of pairs is empty (e.g., input nums is empty),
                ;; or if all costs are 0, total-cost-sum would be 0.
                ;; In such a case, any target-x works, 0 is a safe default.
                0
                (let* ([pair (car remaining-pairs)]
                       [num (car pair)]
                       [c (cdr pair)]
                       [new-current-cost-sum (+ current-cost-sum c)])
                  (if (>= (* new-current-cost-sum 2) total-cost-sum)
                      num ; This num is the weighted median
                      (loop new-current-cost-sum (cdr remaining-pairs))))))])

    ;; Calculate the total cost using the determined target-x-val
    (foldl (lambda (num c acc)
             (+ acc (* (abs (- num target-x-val)) c)))
           0
           nums
           cost)))