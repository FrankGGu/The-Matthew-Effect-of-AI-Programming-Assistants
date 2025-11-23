(define (min-sub-array-len target nums)
  (let* ((n (length nums))
         (min-len (add1 n)))
    (let loop ((left 0) (right 0) (sum 0))
      (cond
        [(>= right n)
         (if (>= sum target)
             (min min-len (- right left))
             min-len)]
        [else
         (let ((new-sum (+ sum (list-ref nums right))))
           (cond
             [(>= new-sum target)
              (let loop2 ((l left) (s new-sum))
                (cond
                  [(>= s target)
                   (loop2 (add1 l) (- s (list-ref nums l)))]
                  [else
                   (loop (add1 l) (add1 right) s)]))]
             [else
              (loop left (add1 right) new-sum)]))]))
    (if (= min-len (add1 n)) 0 min-len)))