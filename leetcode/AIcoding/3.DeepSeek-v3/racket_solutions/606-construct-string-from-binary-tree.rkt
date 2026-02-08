(define/contract (tree2str t)
  (-> (or/c null? tree-node?) string?)
  (cond
    [(null? t) ""]
    [else
     (let ([left (tree2str (tree-node-left t))]
           [right (tree2str (tree-node-right t))])
       (cond
         [(and (string=? left "") (string=? right "")) (number->string (tree-node-val t))]
         [(string=? right "") (string-append (number->string (tree-node-val t)) "(" left ")")]
         [else (string-append (number->string (tree-node-val t)) "(" left ")(" right ")")]))]))