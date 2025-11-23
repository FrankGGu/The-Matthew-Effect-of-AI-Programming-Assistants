(struct TreeNode (val left right))

(define (find-target root k)
  (define seen (make-hash)) ; Use a mutable hash table to store seen values

  (define (dfs node)
    (cond
      [(not node) #f] ; Base case: if node is null, no pair can be formed
      [else
       (define current-val (TreeNode-val node))
       (define complement (- k current-val))

       ;; Check if the complement of the current node's value exists in the hash table
       (if (hash-has-key? seen complement)
           #t ; If found, a pair sums to k
           (begin
             ;; Add the current node's value to the hash table
             (hash-set! seen current-val #t) ; The value associated with the key doesn't matter, only its presence

             ;; Recursively search in the left and right subtrees
             ;; Return true if a pair is found in either subtree
             (or (dfs (TreeNode-left node))
                 (dfs (TreeNode-right node)))))]))

  (dfs root))