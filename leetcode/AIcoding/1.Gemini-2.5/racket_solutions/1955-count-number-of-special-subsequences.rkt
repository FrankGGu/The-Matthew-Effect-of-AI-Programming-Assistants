(define (count-special-subsequences nums)
  (let* ((MOD 1000000007))
    (let loop ((nums-list nums)
               (dp0 0)
               (dp1 0)
               (dp2 0))
      (if (empty? nums-list)
          dp2
          (let ((num (car nums-list)))
            (cond
              ((= num 0)
               (loop (cdr nums-list)
                     (modulo (+ (* 2 dp0) 1) MOD)
                     dp1
                     dp2))
              ((= num 1)
               (loop (cdr nums-list)
                     dp0
                     (modulo (+ (* 2 dp1) dp0) MOD)
                     dp2))
              ((= num 2)
               (loop (cdr nums-list)
                     dp0
                     dp1
                     (modulo (+ (* 2 dp2) dp1) MOD)))))))))