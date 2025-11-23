(define (count-subarrays-where-max-element-appears-at-least-k-times nums k)
  (let* ([n (length nums)]
         [max-val (if (null? nums)
                       -1 ; Should not happen based on constraints (1 <= nums.length)
                       (apply max nums))])
    (let loop ([left 0]
               [right 0]
               [count-max-val 0]
               [ans 0])
      (if (= right n)
          ans
          (let* ([current-num (list-ref nums right)]
                 [new-count-max-val (if (= current-num max-val)
                                        (+ count-max-val 1)
                                        count-max-val)])
            (let inner-loop ([current-left left]
                             [current-count-max-val new-count-max-val]
                             [current-ans ans])
              (if (>= current-count-max-val k)
                  (let* ([num-at-left (list-ref nums current-left)]
                         [next-count-max-val (if (= num-at-left max-val)
                                                 (- current-count-max-val 1)
                                                 current-count-max-val)])
                    (inner-loop (+ current-left 1)
                                next-count-max-val
                                (+ current-ans (- n right))))
                  (loop current-left (+ right 1) current-count-max-val current-ans))))))))