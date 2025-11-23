#lang racket

(struct TreeNode (val left right))

(define (smallest-string-from-leaf root)
  (define min-str #f)

  (define (dfs node current-char-list)
    (when node
      (define char-val (integer->char (+ (char->integer #\a) (TreeNode-val node))))
      (define new-char-list (cons char-val current-char-list))

      (if (and (not (TreeNode-left node)) (not (TreeNode-right node)))
          (let ([current-full-str (list->string new-char-list)])
            (if (or (not min-str) (string<? current-full-str min-str))
                (set! min-str current-full-str)))
          (begin
            (dfs (TreeNode-left node) new-char-list)
            (dfs (TreeNode-right node) new-char-list)))))

  (dfs root '())
  min-str)