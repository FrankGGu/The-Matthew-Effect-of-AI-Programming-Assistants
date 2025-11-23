#lang racket

(require racket/set)

(struct tree-node (val left right))

(struct find-elements (recovered-values))

(define (recover-and-store node current-assigned-val recovered-set)
  (when node
    ;; Add the current assigned value to the set
    (set-add! recovered-set current-assigned-val)

    ;; Recurse for left child
    (recover-and-store (tree-node-left node)
                       (+ (* 2 current-assigned-val) 1)
                       recovered-set)

    ;; Recurse for right child
    (recover-and-store (tree-node-right node)
                       (+ (* 2 current-assigned-val) 2)
                       recovered-set)))

(define (find-elements-init root)
  (define s (set)) ; Create a new mutable set to store recovered values
  (recover-and-store root 0 s) ; Start recovery from root with value 0
  (find-elements s)) ; Create an instance of FindElements with the populated set

(define (find-elements-find fe target)
  (set-member? (find-elements-recovered-values fe) target))