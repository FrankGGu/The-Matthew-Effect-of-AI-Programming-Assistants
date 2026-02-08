(struct TreeNode (val left right))

(define (serialize root)
  (cond
    [(not root) "#"]
    [else
     (string-append
      (number->string (TreeNode-val root))
      ","
      (serialize (TreeNode-left root))
      ","
      (serialize (TreeNode-right root)))]))

(define (deserialize data)
  (let* ([tokens (string-split data ",")])
    (define (deserialize-helper tokens-list)
      (let ([current-token (car tokens-list)])
        (cond
          [(string=? current-token "#")
           (list #f (cdr tokens-list))]
          [else
           (let* ([val (string->number current-token)]
                  [left-result (deserialize-helper (cdr tokens-list))]
                  [left-node (car left-result)]
                  [remaining-tokens-after-left (cdr left-result)]
                  [right-result (deserialize-helper remaining-tokens-after-left)]
                  [right-node (car right-result)]
                  [remaining-tokens-after-right (cdr right-result)])
             (list (TreeNode val left-node right-node) remaining-tokens-after-right))])))
    (car (deserialize-helper tokens))))