#lang racket

(define -inf.0 (- (expt 10 18))) ; A sufficiently small number for negative infinity

(define (kadane arr)
  (if (empty? arr)
      0 ; If the array is empty, the maximum subarray sum is 0.
      (let loop ((lst arr)
                 (max-so-far -inf.0) ; Stores the maximum sum found so far
                 (current-max 0))    ; Stores the maximum sum ending at the current position
        (if (empty? lst)
            max-so-far
            (let* ((n (car lst))
                   (new-current-max (+ current-max n))
                   (updated-current-max (if (< new-current-max 0) 0 new-current-max))
                   (new-max-so-far (max max-so-far new-current-max)))
              (loop (cdr lst) new-max-so-far updated-current-max))))))

(define (maximize-subarray-sum-after-removing-one-element nums)
  (if (empty? nums)
      0 ; If the input list is empty, the max sum is 0.
      (let* ((unique-elements (set->list (list->set nums))) ; Get all unique elements from the input list
             (max-overall-sum -inf.0)) ; Initialize the global maximum sum to negative infinity
        ; Iterate through each unique element
        (for-each (lambda (val-to-remove)
                    ; Filter out all occurrences of the current unique element
                    (let* ((filtered-nums (filter (lambda (x) (not (= x val-to-remove))) nums))
                           ; Calculate the maximum subarray sum for the filtered list using Kadane's algorithm
                           (current-max-sum (kadane filtered-nums)))
                      ; Update the global maximum sum with the result from the current filtered list
                      (set! max-overall-sum (max max-overall-sum current-max-sum))))
                  unique-elements)
        max-overall-sum)))