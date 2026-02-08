(define (can-reach-portal n roll)
  (define (dfs pos visited)
    (if (or (not (<= 0 pos n)) (set-member? visited pos)) 
        #f
        (if (= pos n) 
            #t
            (or (dfs (+ pos roll) (set-add visited pos))
                (dfs (- pos roll) (set-add visited pos))))))
  (dfs 0 (set-empty)))