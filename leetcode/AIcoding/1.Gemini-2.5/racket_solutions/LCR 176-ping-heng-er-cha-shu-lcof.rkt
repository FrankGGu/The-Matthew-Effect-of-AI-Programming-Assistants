(struct TreeNode (val left right))

(define (is-balanced root)
  (define (check-height node)
    (cond
      [(null? node) 0]
      [else
       (let* ([left-height (check-height (TreeNode-left node))]
              [right-height (check-height (TreeNode-right node))])
         (cond
           [(or (= left-height -1)
                (= right-height -1)
                (> (abs (- left-height right-height)) 1))
            -1]
           [else
            (+ 1 (max left-height right-height))]))]))

  (not (= (check-height root) -1)))