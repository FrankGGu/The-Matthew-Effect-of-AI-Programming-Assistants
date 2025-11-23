(define (tree2str root)
  (cond
    [(null? root) ""]
    [(and (null? (tree-left root)) (null? (tree-right root))) (number->string (tree-val root))]
    [(null? (tree-right root)) (string-append (number->string (tree-val root)) "(" (tree2str (tree-left root)) ")")]
    [else (string-append (number->string (tree-val root)) "(" (tree2str (tree-left root)) ")(" (tree2str (tree-right root)) ")")]))