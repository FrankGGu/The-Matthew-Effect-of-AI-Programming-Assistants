(define (can-three-parts-equal-sum arr)
  (let* ([total-sum (apply + arr)]
         [n (length arr)])
    (if (not (= (modulo total-sum 3) 0))
        #f
        (let ([target-sum (/ total-sum 3)])
          (let loop ([current-sum 0]
                     [found-parts 0]
                     [remaining-arr arr]
                     [idx 0])
            (cond
              [(null? remaining-arr)
               #f] ; Reached end, but didn't find two valid partition points before the end
              [else
               (let ([new-current-sum (+ current-sum (car remaining-arr))])
                 (if (= new-current-sum target-sum)
                     (let ([new-found-parts (+ found-parts 1)])
                       (if (and (= new-found-parts 2)
                                (< idx (- n 1))) ; Check if the second partition point is not the last element
                           #t ; Found two parts, and there's a third non-empty part remaining
                           (loop 0 new-found-parts (cdr remaining-arr) (+ idx 1))))
                     (loop new-current-sum found-parts (cdr remaining-arr) (+ idx 1))))]))))))