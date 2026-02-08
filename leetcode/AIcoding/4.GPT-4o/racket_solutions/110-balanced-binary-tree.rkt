(define (isBalanced root)
  (define (height node)
    (if (null? node)
        0
        (let ((left-height (height (node-left node)))
              (right-height (height (node-right node))))
          (if (or (eq? left-height -1) (eq? right-height -1) 
                  (> (abs (- left-height right-height)) 1))
              -1
              (+ 1 (max left-height right-height))))))
  (not (= (height root) -1)))