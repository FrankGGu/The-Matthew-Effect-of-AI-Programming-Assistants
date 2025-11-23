(define (max-operations-with-same-score-ii nums-list)
  (define nums (list->vector nums-list))
  (define n (vector-length nums))

  (define (get-val vec idx)
    (vector-ref vec idx))

  (define (solve target-score)
    (define memo (make-hash))

    (define (dp i j)
      (cond
        ((>= i j) 0) ; Base case: subarray has 0 or 1 element, no more operations possible
        ((hash-has-key? memo (cons i j))
         (hash-ref memo (cons i j)))
        (else
         (let ((res 0))
           ;; Option 1: Remove nums[i] and nums[i+1]
           ;; This is possible if there are at least two elements at the beginning of the current subarray [i, j].
           ;; i.e., i+1 must be a valid index within [i, j].
           (when (and (<= (+ i 1) j)
                      (= (+ (get-val nums i) (get-val nums (+ i 1))) target-score))
             (set! res (max res (+ 1 (dp (+ i 2) j)))))

           ;; Option 2: Remove nums[j-1] and nums[j]
           ;; This is possible if there are at least two elements at the end of the current subarray [i, j].
           ;; i.e., j-1 must be a valid index within [i, j].
           (when (and (>= (- j 1) i)
                      (= (+ (get-val nums (- j 1)) (get-val nums j)) target-score))
             (set! res (max res (+ 1 (dp i (- j 2))))))

           ;; Option 3: Remove nums[i] and nums[j]
           ;; This is possible if there are elements at both ends of the current subarray [i, j].
           ;; The condition i < j is already handled by the base case.
           (when (= (+ (get-val nums i) (get-val nums j)) target-score)
             (set! res (max res (+ 1 (dp (+ i 1) (- j 1))))))

           (hash-set! memo (cons i j) res)
           res))))
    (dp 0 (- n 1)))

  ;; According to problem constraints, n is at least 2.
  ;; Therefore, indices 0, 1, n-2, n-1 are always valid for initial score calculations.
  (let* ((score1 (+ (get-val nums 0) (get-val nums 1)))
         (score2 (+ (get-val nums (- n 2)) (get-val nums (- n 1))))
         (score3 (+ (get-val nums 0) (get-val nums (- n 1))))
         (res1 (solve score1))
         (res2 (solve score2))
         (res3 (solve score3)))
    (max res1 res2 res3)))