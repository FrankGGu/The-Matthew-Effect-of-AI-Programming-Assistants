#lang racket/base

(struct TreeNode (val left right))

(define (find-duplicate-subtrees root)
  (define counts (make-hash))
  (define result '())

  (define (traverse node)
    (if (eq? node #f)
        "#,"
        (let* ((left-serial (traverse (TreeNode-left node)))
               (right-serial (traverse (TreeNode-right node)))
               (current-serial (string-append
                                (number->string (TreeNode-val node))
                                ","
                                left-serial
                                right-serial)))
          (hash-set! counts current-serial (+ (hash-ref counts current-serial 0) 1))
          (when (= (hash-ref counts current-serial) 2)
            (set! result (cons node result)))
          current-serial)))

  (traverse root)
  result)