(define (sum-root-to-leaf root)
  (define (dfs node current-number)
    (cond
      [(null? node) 0]
      [else
       (let* ([new-number (+ (* current-number 2) (.-val node))])
         (cond
           [(and (null? (.-left node)) (null? (.-right node))) new-number]
           [else (+ (dfs (.-left node) new-number) (dfs (.-right node) new-number))]))]))
  (dfs root 0))