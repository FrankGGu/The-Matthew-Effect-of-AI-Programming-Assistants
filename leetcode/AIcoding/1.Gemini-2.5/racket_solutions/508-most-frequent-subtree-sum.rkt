#lang racket

(define (find-frequent-tree-sum root)
  (define frequencies (make-hash))

  (define (dfs-sum node)
    (if (eq? node null)
        0
        (let* ((left-sum (dfs-sum (TreeNode-left node)))
               (right-sum (dfs-sum (TreeNode-right node)))
               (current-subtree-sum (+ (TreeNode-val node) left-sum right-sum)))
          (hash-update! frequencies current-subtree-sum add1 0)
          current-subtree-sum)))

  (unless (eq? root null)
    (dfs-sum root))

  (let ((max-freq 0)
        (result-sums '()))
    (hash-for-each
     frequencies
     (lambda (sum freq)
       (cond
         ((> freq max-freq)
          (set! max-freq freq)
          (set! result-sums (list sum)))
         ((= freq max-freq)
          (set! result-sums (cons sum result-sums))))))
    result-sums))