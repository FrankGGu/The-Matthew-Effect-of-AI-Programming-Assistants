#lang racket

(define (min-operations grid x)
  (let* ([flat-list (apply append grid)]
         [n (length flat-list)])

    ;; According to LeetCode problem constraints, grid is non-empty (m, n >= 1).
    ;; If n were 0, it would already be uni-value with 0 operations.
    ;; We proceed assuming n >= 1.

    ;; Check if all elements have the same remainder when divided by x.
    ;; If not, it's impossible to make them uni-value by adding/subtracting x.
    (let ([first-rem (remainder (car flat-list) x)])
      (if (not (andmap (lambda (num) (= (remainder num x) first-rem)) flat-list))
          -1 ; Return -1 if not all congruent modulo x
          (let* ([sorted-list (sort flat-list <)]
                 ;; The optimal target value 'k' that minimizes the sum of absolute differences
                 ;; (sum |a_i - k|) is the median of the sorted list.
                 ;; For an even number of elements, any value between the two middle elements
                 ;; (inclusive) minimizes this sum. We can pick the lower of the two middle
                 ;; elements using floor division for the index.
                 [median (list-ref sorted-list (floor (/ n 2)))])
            ;; Calculate the total number of operations.
            ;; Each difference (abs (- num median)) is guaranteed to be divisible by x
            ;; because num % x == median % x (as median is an element from the list).
            (foldl (lambda (num acc)
                     (+ acc (/ (abs (- num median)) x)))
                   0
                   sorted-list))))))