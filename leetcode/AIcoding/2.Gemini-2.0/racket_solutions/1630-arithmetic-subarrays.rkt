(define (check-arithmetic? nums start end)
  (let* ([sub-array (list->vector (list-sort < (vector->list (vector-slice nums start (+ end 1)))))]
         [n (vector-length sub-array)])
    (if (< n 3)
        #t
        (let ([diff (- (vector-ref sub-array 1) (vector-ref sub-array 0))])
          (let loop ([i 2])
            (cond
              [(>= i n) #t]
              [(= (- (vector-ref sub-array i) (vector-ref sub-array (- i 1))) diff) (loop (+ i 1))]
              [else #f]))))))

(define (arithmetic-subarrays nums l r)
  (let ([n (length l)])
    (let loop ([i 0] [result '()])
      (if (= i n)
          result
          (loop (+ i 1) (append result (list (check-arithmetic? nums (list-ref l i) (list-ref r i)))))))))