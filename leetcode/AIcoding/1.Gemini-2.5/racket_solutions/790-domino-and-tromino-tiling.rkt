(define (num-tilings n)
  (define MOD 1000000007)

  (cond
    ((= n 1) 1)
    ((= n 2) 2)
    (else
     (let loop ((i 3)
                (dp_prev2 1) ; Represents dp[1]
                (dp_prev1 2) ; Represents dp[2]
                (p_prev1 1))  ; Represents p[2]
       (if (> i n)
           dp_prev1
           (let* ((current_dp (+ dp_prev1 dp_prev2 (* 2 p_prev1)))
                  (current_p (+ dp_prev2 p_prev1)))
             (loop (+ i 1)
                   dp_prev1
                   (modulo current_dp MOD)
                   (modulo current_p MOD))))))))