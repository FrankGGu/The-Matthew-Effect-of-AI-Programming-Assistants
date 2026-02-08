(define-struct tree-node (val left right))

(define (tree2str root)
  (cond
    [(null? root) ""]
    [else
     (let* ([val-str (number->string (tree-node-val root))]
            [left-node (tree-node-left root)]
            [right-node (tree-node-right root)]
            [left-str (tree2str left-node)]
            [right-str (tree2str right-node)])
       (cond
         [(and (null? left-node) (null? right-node)) val-str]
         [(null? right-node) (string-append val-str "(" left-str ")")]
         [else (string-append val-str "(" left-str ")" "(" right-str ")")]
         ))]))