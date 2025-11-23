(define (recover-array nums)
  (let* ((n (length nums))
         (sorted-nums (sort nums <))
         (result '()))
    (for ([i (in-range 1 n)])
      (let* ((diff (- (list-ref sorted-nums i) (car sorted-nums)))
             (if (and (even? diff) (> diff 0))
                 (let loop ([left sorted-nums] [right (cdr sorted-nums)] [k (/ diff 2)] [temp '()])
                   (cond
                     [(empty? right) #f]
                     [(and (empty? left) (not (empty? right))) #f]
                     [else (let ((left-head (car left))
                                 (right-head (car right)))
                             (cond
                               [(> right-head (+ left-head (* 2 k))) (loop (cdr left) right k temp)]
                               [(= right-head (+ left-head (* 2 k)))
                                (if (empty? (cdr left))
                                    (if (empty? (cdr right))
                                        (begin
                                          (set! result (append temp (list (+ left-head k))))
                                          #t)
                                        #f)
                                    (loop (cdr left) (cdr right) k (append temp (list (+ left-head k)))))]
                               [else #f]))]))))
                 #f))
      (when (not (equal? result '())) (return result))))
  result)