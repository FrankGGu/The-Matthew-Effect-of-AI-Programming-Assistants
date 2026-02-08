(define (pseudo-palindromic-paths root)
  (define (dfs node count)
    (if (null? node)
        0
        (begin
          (set! count (bit-xor count (ash 1 (node-value node))))
          (if (and (null? (left node)) (null? (right node)))
              (if (= (bit-count count) 1) 1 0)
              (+ (dfs (left node) count) (dfs (right node) count))))))
  (dfs root 0))

(define (node-value node)
  (if node
      (node-val node)
      0))

(define (left node)
  (if node
      (node-left node)
      null))

(define (right node)
  (if node
      (node-right node)
      null))