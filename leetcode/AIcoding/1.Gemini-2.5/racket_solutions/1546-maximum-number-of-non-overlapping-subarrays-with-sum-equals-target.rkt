#lang racket

(define (max-non-overlapping-subarrays nums target)
  (let loop ((current-sum 0)
             (count 0)
             (prefix-sums (hash-set 0))
             (remaining-nums nums))
    (if (empty? remaining-nums)
        count
        (let* ((num (car remaining-nums))
               (next-sum (+ current-sum num))
               (needed-sum (- next-sum target)))
          (if (hash-set-contains? prefix-sums needed-sum)
              (loop 0
                    (add1 count)
                    (hash-set 0)
                    (cdr remaining-nums))
              (loop next-sum
                    count
                    (hash-set-add prefix-sums next-sum)
                    (cdr remaining-nums)))))))