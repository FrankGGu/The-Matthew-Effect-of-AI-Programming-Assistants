(require racket/list)

(define (rob nums)
  (define (rob-linear lst)
    (if (empty? lst)
        0
        (let loop ((current-list lst)
                   (prev1 0) ; max amount robbed up to the previous house
                   (prev2 0)) ; max amount robbed up to the house before the previous
          (if (empty? current-list)
              prev1
              (let* ((current-house-value (car current-list))
                     (new-prev1 (max prev1 (+ prev2 current-house-value))))
                (loop (cdr current-list) new-prev1 prev1))))))

  (cond
    ((empty? nums) 0)
    ((= (length nums) 1) (car nums))
    (else
     (let* ((n (length nums))
            ; Case 1: Rob houses from 0 to n-2 (exclude the last house)
            (result1 (rob-linear (take nums (- n 1))))
            ; Case 2: Rob houses from 1 to n-1 (exclude the first house)
            (result2 (rob-linear (drop nums 1))))
       (max result1 result2))))))