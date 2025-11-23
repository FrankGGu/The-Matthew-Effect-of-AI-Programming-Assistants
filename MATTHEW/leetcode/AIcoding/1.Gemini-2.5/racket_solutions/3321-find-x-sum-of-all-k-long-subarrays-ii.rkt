#lang racket

(define (find-x-sum-of-all-k-long-subarrays-ii nums k)
  (let* ([n (length nums)])
    (cond
      [(< n k) '()] ; If k is greater than the length of nums, no k-long subarrays exist.
      [else
       ;; Step 1: Calculate the sum of the first k elements (initial window).
       (let initial-window-sum ([lst nums] [count k] [current-sum 0])
         (if (zero? count)
             ;; Step 2: Once the initial sum is calculated, start sliding the window.
             ;; `leading-elements` are the elements that will enter the window.
             ;; `trailing-elements` are the elements that will leave the window.
             (let slide-window ([leading-elements (drop nums k)]
                                [trailing-elements nums]
                                [current-sum current-sum]
                                [acc (list current-sum)]) ; Accumulator for results, stores in reverse order.
               (if (empty? leading-elements)
                   ;; Base case: No more elements to enter, all windows processed.
                   (reverse acc) ; Reverse the accumulated results to get the correct order.
                   ;; Recursive step: Slide the window one position to the right.
                   (let* ([leaving-val (car trailing-elements)] ; Element leaving the window.
                          [entering-val (car leading-elements)] ; Element entering the window.
                          [new-sum (- (+ current-sum entering-val) leaving-val)])
                     (slide-window (cdr leading-elements) ; Move leading pointer.
                                   (cdr trailing-elements) ; Move trailing pointer.
                                   new-sum
                                   (cons new-sum acc))))) ; Add new sum to accumulator.
             ;; Recursive step for initial sum calculation.
             (initial-window-sum (cdr lst)
                                 (- count 1)
                                 (+ current-sum (car lst)))))])))