(define-struct TreeNode (val left right))

(define (deepest-leaves-sum root)
  (if (not root)
      0
      (cdr (get-deepest-info root 0))))

(define (get-deepest-info node current-depth)
  (cond
    [(not node)
     (cons -1 0)] ; Represents no valid depth and zero sum
    [(and (not (TreeNode-left node)) (not (TreeNode-right node)))
     (cons current-depth (TreeNode-val node))]
    [else
     (let* ([left-info (get-deepest-info (TreeNode-left node) (+ current-depth 1))]
            [right-info (get-deepest-info (TreeNode-right node) (+ current-depth 1))]
            [left-max-depth (car left-info)]
            [left-sum (cdr left-info)]
            [right-max-depth (car right-info)]
            [right-sum (cdr right-info)])
       (cond
         [(> left-max-depth right-max-depth)
          left-info]
         [(> right-max-depth left-max-depth)
          right-info]
         [else ; left-max-depth == right-max-depth
          (cons left-max-depth (+ left-sum right-sum))]))]))