#lang racket

(define (split-array nums k)
  (let* ([total-sum (apply + nums)]
         [max-val (apply max nums)] ; nums.length >= 1, so nums is never empty.
         [low max-val]
         [high total-sum]
         [ans high])

    ;; Helper function to check if the array can be split into 'k' or fewer subarrays
    ;; such that each subarray's sum does not exceed 'max-sum-limit'.
    (define (can-split? max-sum-limit)
      (let loop ([lst nums]
                 [num-subarrays 1]
                 [current-sum 0])
        (cond
          [(empty? lst)
           (<= num-subarrays k)]
          [else
           (let ([n (car lst)])
             ;; If a single element is greater than the allowed max-sum-limit, it's impossible.
             (if (> n max-sum-limit)
                 #f
                 (if (<= (+ current-sum n) max-sum-limit)
                     (loop (cdr lst) num-subarrays (+ current-sum n))
                     ;; Start a new subarray
                     ;; If starting a new subarray makes it k+1 or more, it's impossible.
                     (if (>= (add1 num-subarrays) (add1 k))
                         #f
                         (loop (cdr lst) (add1 num-subarrays) n)))))])))

    ;; Binary search for the minimum possible largest sum
    (let binary-search ([l low] [h high] [res ans])
      (if (> l h)
          res
          (let ([mid (quotient (+ l h) 2)])
            (if (can-split? mid)
                (binary-search l (- mid 1) mid) ; Try to find a smaller max-sum-limit
                (binary-search (+ mid 1) h res)))))))