(define (max-non-overlapping-subarrays nums target)
  (let loop ([nums nums] [count 0] [end -1])
    (cond
      [(null? nums) count]
      [else
       (let ([sum 0] [found #f])
         (for/or ([i (in-range (length nums))]
                  #:break found)
           (set! sum (+ sum (list-ref nums i)))
           (if (= sum target)
               (begin (set! found #t) (+ i 1))
               #f)))
         (if found
             (loop (drop nums found) (+ count 1) (+ end found))
             count)])))