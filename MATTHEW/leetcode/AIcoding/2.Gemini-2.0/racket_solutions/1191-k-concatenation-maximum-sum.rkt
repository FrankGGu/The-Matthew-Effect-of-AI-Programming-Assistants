(define (k-concatenation-max-sum nums k)
  (define (kadane arr)
    (define (helper arr current-max global-max)
      (cond
        [(empty? arr) global-max]
        [else
         (let* ([new-current-max (max 0 (+ current-max (car arr)))]
                [new-global-max (max global-max new-current-max)])
           (helper (cdr arr) new-current-max new-global-max))]))
    (helper arr 0 (car arr)))

  (define (sum arr)
    (foldl + 0 arr))

  (let* ([n (length nums)]
         [arr-sum (sum nums)]
         [max-sum-1 (kadane nums)])
    (cond
      [(= k 1) max-sum-1]
      [else
       (let* ([arr-double (append nums nums)]
              [max-sum-2 (kadane arr-double)])
         (if (> arr-sum 0)
             (max max-sum-2 (+ max-sum-2 (* (- k 2) arr-sum)))
             max-sum-2))])))