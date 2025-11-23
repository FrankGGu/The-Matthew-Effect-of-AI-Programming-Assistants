#lang racket

(struct TreeNode (val left right) #:mutable)

(define (merge-bsts trees)
  (define root-map (make-hash))       ; Maps root value -> TreeNode for all input trees
  (define all-nodes-map (make-hash))  ; Maps node value -> TreeNode for all nodes across all trees (for uniqueness check)
  (define child-vals-set (make-hash-set)) ; Set of values that appear as children in any input tree

  ;; Use call/ec for early exit with #null on error conditions
  (call/ec
   (lambda (return-null)
     ;; Step 1: Populate maps and sets, and check for duplicate node values
     (for ([tree trees])
       (define (traverse node is-root?)
         (when node
           (define node-val (TreeNode-val node))

           ;; Check for duplicate node values across all input trees
           (when (hash-has-key? all-nodes-map node-val)
             (return-null #null)) ; Duplicate found, invalid input
           (hash-set! all-nodes-map node-val node)

           (when is-root?
             (hash-set! root-map node-val node))

           (when (TreeNode-left node)
             (hash-set! child-vals-set (TreeNode-val (TreeNode-left node))))
           (traverse (TreeNode-left node) #f)

           (when (TreeNode-right node)
             (hash-set! child-vals-set (TreeNode-val (TreeNode-right node))))
           (traverse (TreeNode-right node) #f)))
       (traverse tree #t)))

     ;; Step 2: Find the unique potential final root
     (define final-root-candidate #f)
     (for ([root-val (hash-keys root-map)])
       (when (not (hash-has-key? child-vals-set root-val))
         (when final-root-candidate
           (return-null #null)) ; More than one candidate root found, invalid
         (set! final-root-candidate (hash-ref root-map root-val))))

     (unless final-root-candidate
       (return-null #null)) ; No candidate root found (e.g., empty input, or all roots are children)

     ;; Step 3: Perform DFS to merge trees and validate BST property
     (define visited-roots (make-hash-set)) ; Tracks roots of input trees that have been merged

     ;; `dfs` returns the merged TreeNode, or #null for an empty child, or #f for a BST violation.
     (define (dfs current-node min-val max-val)
       (when (not current-node)
         (return #null)) ; #null represents an empty child slot, not a failure

       (define node-val (TreeNode-val current-node))

       ;; BST validation check
       (when (or (<= node-val min-val) (>= node-val max-val))
         (return #f)) ; BST violation, signal failure

       (define node-to-process current-node)
       ;; If `current-node` corresponds to an unvisited root of an input tree,
       ;; we "attach" that entire input tree here.
       (when (and (hash-has-key? root-map node-val) (not (hash-has-key? visited-roots node-val)))
         (hash-set! visited-roots node-val)
         (set! node-to-process (hash-ref root-map node-val)))
       ;; Else, `node-to-process` remains `current-node` (it's an internal node of an already merged tree).

       ;; Recursively process children
       (define merged-left (dfs (TreeNode-left node-to-process) min-val node-val))
       (when (eq? merged-left #f) (return #f)) ; Propagate failure from left subtree

       (define merged-right (dfs (TreeNode-right node-to-process) node-val max-val))
       (when (eq? merged-right #f) (return #f)) ; Propagate failure from right subtree

       ;; Update children of the current node-to-process
       (set-TreeNode-left! node-to-process merged-left)
       (set-TreeNode-right! node-to-process merged-right)

       (return node-to-process)) ; Return the (potentially modified) node

     (define merged-tree (dfs final-root-candidate -inf.0 +inf.0)) ; Start DFS with the candidate root and infinite bounds

     ;; Step 4: Final checks
     ;; - If DFS returned #f, it means a BST violation occurred.
     ;; - If the number of visited roots does not match the total number of input roots,
     ;;   it means not all trees were merged.
     (when (or (eq? merged-tree #f)
               (not (= (hash-count visited-roots) (hash-count root-map))))
       (return-null #null))

     ;; All checks passed, return the successfully merged tree
     merged-tree)))