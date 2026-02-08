(define (nums-same-consec-diff n k)
  (define results '())

  (define (dfs current-num current-length)
    (when (= current-length n)
      (set! results (cons current-num results)))
    (when (< current-length n)
      (let* ((last-digit (modulo current-num 10)))
        ;; Explore next-digit = last-digit + k
        (let ((next-digit-plus (+ last-digit k)))
          (when (and (>= next-digit-plus 0) (<= next-digit-plus 9))
            (dfs (+ (* current-num 10) next-digit-plus) (+ current-length 1))))

        ;; Explore next-digit = last-digit - k
        ;; Only if k is not 0, to avoid duplicate calls when k=0
        (when (not (= k 0))
          (let ((next-digit-minus (- last-digit k)))
            (when (and (>= next-digit-minus 0) (<= next-digit-minus 9))
              (dfs (+ (* current-num 10) next-digit-minus) (+ current-length 1))))))))

  ;; Initial calls
  (if (= n 1)
      ;; If n=1, all single digits 0-9 are valid
      (for-each (lambda (i) (set! results (cons i results))) (range 10))
      ;; If n > 1, first digit cannot be 0
      (for-each (lambda (i) (dfs i 1)) (range 1 10))) ; Start with digits 1-9

  (reverse results))