(define/contract (smallest-from-leaf root)
  (-> (or/c null? tree-node?) string?)
  (define (dfs node path)
    (if (null? node)
        ""
        (let* ([current-char (integer->char (+ (node-val node) 97))]
               [new-path (cons current-char path)]
               [left (node-left node)]
               [right (node-right node)])
          (if (and (null? left) (null? right))
              (list->string new-path)
              (let ([left-str (if (null? left) "" (dfs left new-path))]
                    [right-str (if (null? right) "" (dfs right new-path))])
                (cond
                  [(string=? left-str "") right-str]
                  [(string=? right-str "") left-str]
                  [else (if (string<? left-str right-str) left-str right-str)]))))))
  (dfs root '()))

(define (node-val node) (vector-ref node 0))
(define (node-left node) (vector-ref node 1))
(define (node-right node) (vector-ref node 2))