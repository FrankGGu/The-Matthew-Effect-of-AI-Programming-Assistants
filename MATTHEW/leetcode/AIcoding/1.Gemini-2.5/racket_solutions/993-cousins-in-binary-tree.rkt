(struct TreeNode (val left right))

(define (is-cousins root x y)
  ;; Helper function to find the depth and parent's value of a target node.
  ;; Returns (list depth parent-val) if target is found, otherwise #f.
  ;; `current-depth` starts at 0 for the root.
  ;; `parent-val` is a sentinel value (e.g., -1) for the root's parent.
  (define (find-node-info node target current-depth parent-val)
    (cond
      [(null? node) #f]
      [(= (TreeNode-val node) target)
       (list current-depth parent-val)]
      [else
       (let ([left-result (find-node-info (TreeNode-left node) target (+ current-depth 1) (TreeNode-val node))])
         (if left-result
             left-result
             (find-node-info (TreeNode-right node) target (+ current-depth 1) (TreeNode-val node))))]))

  ;; Find information for node x
  (define info-x (find-node-info root x 0 -1))
  ;; Find information for node y
  (define info-y (find-node-info root y 0 -1))

  ;; Check if both nodes were found (guaranteed by problem constraints)
  ;; and if they meet the conditions for being cousins:
  ;; 1. Same depth: (car info-x) = (car info-y)
  ;; 2. Different parents: (cadr info-x) != (cadr info-y)
  (and info-x info-y
       (= (car info-x) (car info-y))
       (not (= (cadr info-x) (cadr info-y)))))