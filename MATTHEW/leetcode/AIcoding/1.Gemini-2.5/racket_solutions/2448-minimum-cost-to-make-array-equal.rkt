#lang racket

(define (min-cost-to-make-array-equal nums cost)
  ;; Combine nums and cost into pairs and sort them by nums[i]
  (define num-cost-pairs
    (sort (for/list ([n-val (in-list nums)]
                     [c-val (in-list cost)])
            (cons n-val c-val))
          (lambda (a b) (< (car a) (car b)))))

  ;; Calculate the total cost sum
  (define total-cost-sum
    (for/sum ([pair (in-list num-cost-pairs)])
      (cdr pair)))

  ;; Calculate the target sum for finding the weighted median
  (define target-median-cost (/ total-cost-sum 2.0))

  ;; Find the weighted median
  ;; The weighted median is the x_i such that the sum of costs for elements
  ;; smaller than x_i is less than total_cost_sum / 2, and
  ;; the sum of costs for elements less than or equal to x_i is >= total_cost_sum / 2.
  (define (find-median pairs current-sum)
    (let* ([pair (car pairs)]
           [num (car pair)]
           [c (cdr pair)]
           [new-sum (+ current-sum c)])
      (if (>= new-sum target-median-cost)
          num
          (find-median (cdr pairs) new-sum))))

  (define weighted-median-val (find-median num-cost-pairs 0))

  ;; Calculate the total cost for the weighted median
  (define final-min-cost
    (for/sum ([pair (in-list num-cost-pairs)])
      (* (cdr pair) (abs (- (car pair) weighted-median-val)))))

  final-min-cost)