#lang racket

(define (combinationSum3 k n)
  ;; Calculate minimum and maximum possible sum for k distinct numbers from 1 to 9.
  ;; min-possible-sum: sum of 1 to k (e.g., for k=3, 1+2+3=6)
  (define min-possible-sum (/ (* k (+ k 1)) 2))
  ;; max-possible-sum: sum of (10-k) to 9 (e.g., for k=3, 7+8+9=24)
  (define max-possible-sum (/ (* k (+ (- 10 k) 9)) 2))

  ;; Initial pruning: if n is outside the possible sum range, return an empty list immediately.
  (if (or (< n min-possible-sum) (> n max-possible-sum))
      '()
      ;; Use letrec for the recursive backtracking function.
      (letrec ((backtrack (lambda (current-path current-sum current-count start-num)
                            (cond
                              ;; Base case 1: A valid combination is found.
                              ;; The current-count matches k and current-sum matches n.
                              ((and (= current-count k) (= current-sum n))
                               ;; Return a list containing this one combination (reversed to maintain order).
                               (list (reverse current-path)))

                              ;; Base case 2: Pruning conditions.
                              ;; - current-count exceeds k (too many numbers selected).
                              ;; - current-sum exceeds n (sum is already too large).
                              ;; - start-num exceeds 9 (no more numbers from 1 to 9 can be chosen).
                              ((or (> current-count k)
                                   (> current-sum n)
                                   (> start-num 9))
                               '()) ; Return an empty list, as no valid combinations can be formed from this path.

                              ;; Recursive step: Try adding numbers from start-num up to 9.
                              (else
                               (let loop ((i start-num) (acc '()))
                                 ;; Further pruning within the loop:
                                 ;; - If 'i' exceeds 9, all possible numbers have been tried.
                                 ;; - If adding 'i' to current-sum would exceed n, then any larger number 'j > i'
                                 ;;   would also exceed n, so we can stop trying further numbers for this path.
                                 (if (or (> i 9) (> (+ current-sum i) n))
                                     acc ; Return accumulated results for this branch.
                                     ;; Recurse by adding 'i' to the current path and update sum/count.
                                     ;; Then, continue the loop with the next number (i + 1).
                                     (loop (+ i 1)
                                           (append acc (backtrack (cons i current-path)
                                                                  (+ current-sum i)
                                                                  (+ current-count 1)
                                                                  (+ i 1)))))))))))
        ;; Initial call to the backtracking function:
        ;; Start with an empty path, sum 0, count 0, and the first number to try is 1.
        (backtrack '() 0 0 1))))