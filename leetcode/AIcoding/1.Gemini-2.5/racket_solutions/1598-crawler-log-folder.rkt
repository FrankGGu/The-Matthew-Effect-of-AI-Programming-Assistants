(define (min-operations logs)
  (foldl (lambda (log current-depth)
           (cond
             [(string=? log "../")
              (if (> current-depth 0)
                  (- current-depth 1)
                  current-depth)]
             [(string=? log "./")
              current-depth]
             [else
              (+ current-depth 1)]))
         0
         logs))