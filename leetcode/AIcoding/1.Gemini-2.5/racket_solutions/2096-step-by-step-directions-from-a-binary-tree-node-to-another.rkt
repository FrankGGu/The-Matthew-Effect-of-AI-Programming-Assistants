#lang racket

(struct TreeNode (val left right))

(define (get-directions root start-value dest-value)

  (define (find-path current-node target-val path-acc)
    (cond
      ((null? current-node) #f)
      ((= (TreeNode-val current-node) target-val) (reverse path-acc))
      (else
       (let ([left-path (find-path (TreeNode-left current-node) target-val (cons #\L path-acc))])
         (if left-path
             left-path
             (let ([right-path (find-path (TreeNode-right current-node) target-val (cons #\R path-acc))])
               right-path))))))

  (define (lowest-common-ancestor node p-val q-val)
    (cond
      ((null? node) null)
      ((or (= (TreeNode-val node) p-val) (= (TreeNode-val node) q-val)) node)
      (else
       (let ([left-lca (lowest-common-ancestor (TreeNode-left node) p-val q-val)]
             [right-lca (lowest-common-ancestor (TreeNode-right node) p-val q-val)])
         (cond
           ((and (not (null? left-lca)) (not (null? right-lca))) node)
           ((not (null? left-lca)) left-lca)
           (else right-lca))))))

  (let* ([lca (lowest-common-ancestor root start-value dest-value)]
         [path-to-start-list (find-path lca start-value '())]
         [path-to-dest-list (find-path lca dest-value '())])

    (let* ([ups (make-string (length path-to-start-list) #\U)]
           [dest-dir (list->string path-to-dest-list)])
      (string-append ups dest-dir))))