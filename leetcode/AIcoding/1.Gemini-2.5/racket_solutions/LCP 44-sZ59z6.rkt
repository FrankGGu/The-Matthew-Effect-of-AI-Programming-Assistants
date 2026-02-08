(require racket/set)

(define (opening-ceremony-fireworks root)
  (define (collect-all-vals node acc)
    (if (null? node)
        acc
        (let ([current-val (Node-val node)])
          (foldl collect-all-vals
                 (cons current-val acc)
                 (Node-children node)))))

  (if (null? root)
      0
      (set-count (list->set (collect-all-vals root '())))))