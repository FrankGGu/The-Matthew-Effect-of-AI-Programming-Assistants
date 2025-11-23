(define (checkValidString s)
  (define (helper s i balance)
    (cond
      [(= i (string-length s)) (= balance 0)]
      [(> balance (string-length s) - i) #f]
      [else
       (let* ((char (string-ref s i))
              (new-balance (cond
                             [(char=? char #\() (+ balance 1)
                             [(char=? char #\)) (- balance 1)
                             [(char=? char #\*) balance])))
         (or (helper s (+ i 1) new-balance)
             (helper s (+ i 1) balance)
             (helper s (+ i 1) (+ balance 1)))))]))
  (helper s 0 0))