(define (maximumTotalReward operations)
  (define (dp i reward)
    (if (= i (length operations))
        reward
        (let* ((op (list-ref operations i))
               (take (if (equal? (car op) 1) 
                         (+ reward (cadr op)) 
                         reward))
               (skip (dp (+ i 1) reward)))
          (max take skip))))
  (dp 0 0))

(define (maximumTotalRewardMain operations)
  (maximumTotalReward operations))