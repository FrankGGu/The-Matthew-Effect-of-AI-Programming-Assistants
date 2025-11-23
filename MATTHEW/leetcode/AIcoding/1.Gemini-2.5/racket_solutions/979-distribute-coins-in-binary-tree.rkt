(define-struct (TreeNode val left right))

(define (distributeCoins root)
  (define (dfs node)
    ;; Returns a pair: (cons total-moves-in-subtree balance-of-coins-in-subtree)
    ;; The balance is (total coins in subtree) - (total nodes in subtree).
    ;; A positive balance means an excess of coins, a negative balance means a deficit.
    (if (not node)
        (cons 0 0) ; Base case: null node contributes 0 moves and 0 balance
        (let* ([left-result (dfs (TreeNode-left node))]
               [right-result (dfs (TreeNode-right node))]
               [left-moves (car left-result)]
               [left-balance (cdr left-result)]
               [right-moves (car right-result)]
               [right-balance (cdr right-result)])
          (let* ([current-node-balance (- (TreeNode-val node) 1)] ; Coins at current node minus 1 (what it needs)
                 [total-subtree-balance (+ current-node-balance left-balance right-balance)]
                 ;; Total moves are:
                 ;; 1. Moves within the left subtree.
                 ;; 2. Moves within the right subtree.
                 ;; 3. Moves across the edge to/from the left child (abs left-balance).
                 ;; 4. Moves across the edge to/from the right child (abs right-balance).
                 [total-subtree-moves (+ left-moves right-moves (abs left-balance) (abs right-balance))])
            (cons total-subtree-moves total-subtree-balance)))))
  (car (dfs root)))