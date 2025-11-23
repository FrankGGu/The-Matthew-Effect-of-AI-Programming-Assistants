(define (width-of-binary-tree root)
  (define (dfs node level position levels)
    (cond
      [(null? node) levels]
      [else
       (let* ([updated-levels
               (cond
                 [(null? (list-ref levels level (void)))
                  (list-set levels level (cons position position) (void))]
                 [else
                  (let ([existing-range (list-ref levels level (void))])
                    (list-set levels level (cons (min (car existing-range) position) (max (cdr existing-range) position)) (void)))])]
              [left-levels (dfs (car node) (+ level 1) (* position 2) updated-levels)]
              [right-levels (dfs (cdr node) (+ level 1) (+ (* position 2) 1) left-levels)])
         right-levels)]))

  (let ([levels (make-list 3000 (void))])
    (let ([final-levels (dfs root 0 0 levels)])
      (foldl (lambda (level acc)
               (if (void? level)
                   acc
                   (max acc (+ 1 (- (cdr level) (car level))))))
             0
             final-levels))))