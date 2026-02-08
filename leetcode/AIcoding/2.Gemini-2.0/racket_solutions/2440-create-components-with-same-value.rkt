(define (max-value nums)
  (foldl max (car nums) nums))

(define (min-operations nums)
  (let* ((n (length nums))
         (sum (apply + nums)))
    (if (= sum 0)
        (- n 1)
        (let loop ((i 1))
          (cond
            ((> i sum) (- n 1))
            ((= (remainder sum i) 0)
             (let* ((target (/ sum i))
                    (ops (let helper ((lst nums) (curr-sum 0) (count 0))
                            (cond
                              ((null? lst)
                               (if (= curr-sum 0) count #f))
                              ((> curr-sum target) #f)
                              ((= curr-sum target)
                               (helper (cdr lst) 0 (+ count 1)))
                              (else
                               (helper (cdr lst) (+ curr-sum (car lst)) count)))))
               (if ops
                   (- n i)
                   (loop (+ i 1)))))
            (else
             (loop (+ i 1))))))))