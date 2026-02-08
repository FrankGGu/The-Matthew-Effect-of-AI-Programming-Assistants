(define (num-ways nums)
  (define n (length nums))
  (define memo (make-hash))

  (define (combinations n k)
    (hash-ref! memo (cons n k)
               (lambda ()
                 (cond
                   ((or (< k 0) (> k n)) 0)
                   ((or (= k 0) (= k n))) 1)
                   ((= k 1) n)
                   (else (+ (combinations (- n 1) (- k 1))
                            (combinations (- n 1) k)))))))

  (define (dfs nums)
    (if (null? nums)
        1
        (let* ((root (car nums))
               (left (filter (lambda (x) (< x root)) (cdr nums)))
               (right (filter (lambda (x) (> x root)) (cdr nums)))
               (len-left (length left))
               (len-right (length right)))
          (* (combinations (- (+ len-left len-right) 0) len-left)
             (dfs left)
             (dfs right)))))

  (- (dfs nums) 1))