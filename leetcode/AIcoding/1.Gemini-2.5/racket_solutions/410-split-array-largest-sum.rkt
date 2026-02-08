#lang racket

(define (split-array-largest-sum nums k)
  (define nums-vec (list->vector nums))
  (define n (vector-length nums-vec))

  (define (sum-list lst)
    (foldl + 0 lst))

  (define (max-list lst)
    (if (null? lst)
        0 ; Should not happen based on constraints (nums.length >= 1)
        (foldl max 0 lst))) ; 0 is a safe initial max for non-negative numbers

  (define (check max-allowed-sum)
    (define (iter current-idx current-sum num-subarrays)
      (if (= current-idx n)
          num-subarrays
          (let ((current-num (vector-ref nums-vec current-idx)))
            (if (> (+ current-sum current-num) max-allowed-sum)
                ; Start a new subarray with current-num
                (iter (+ current-idx 1) current-num (+ num-subarrays 1))
                ; Continue current subarray
                (iter (+ current-idx 1) (+ current-sum current-num) num-subarrays)))))
    ; Initial state: current-idx 0, current-sum 0, 1 subarray started
    (<= (iter 0 0 1) k)))

  (let* ((total-sum (sum-list nums))
         (min-possible-max-sum (max-list nums)))

    (define low min-possible-max-sum)
    (define high total-sum)
    (define ans high)

    (let loop ((l low) (h high) (a ans))
      (if (> l h)
          a
          (let ((mid (+ l (quotient (- h l) 2))))
            (if (check mid)
                (loop l (- mid 1) mid) ; mid is a possible answer, try smaller
                (loop (+ mid 1) h a)))))))