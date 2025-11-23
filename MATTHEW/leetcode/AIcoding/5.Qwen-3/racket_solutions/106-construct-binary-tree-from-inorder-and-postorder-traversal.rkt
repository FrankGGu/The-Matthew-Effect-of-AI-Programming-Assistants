#lang racket

(define (build-tree inorder postorder)
  (define (helper in-start in-end post-start post-end map)
    (if (> in-start in-end)
        #f
        (let* ((root-val (list-ref postorder post-end))
               (root-index (hash-ref map root-val))
               (left-subtree-size (- root-index in-start)))
          (let ((left (helper in-start (- root-index 1) post-start (- post-end left-subtree-size 1) map))
                (right (helper (+ root-index 1) in-end (- post-end left-subtree-size) (- post-end 1) map)))
            (list root-val left right)))))
  (define map (for/hash ((i (in-range (length inorder))) (val inorder)) (values val i))
  (helper 0 (- (length inorder) 1) 0 (- (length postorder) 1) map))