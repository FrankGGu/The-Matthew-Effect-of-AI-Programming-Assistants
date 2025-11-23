(define (max-ancestor-diff root)
  (define (helper node min-val max-val)
    (if (null? node)
        0
        (let* ([current-val (node-val node)]
               [new-min (min min-val current-val)]
               [new-max (max max-val current-val)]
               [current-diff (max (abs (- current-val min-val)) (abs (- current-val max-val))])
          (max current-diff
               (helper (node-left node) new-min new-max)
               (helper (node-right node) new-min new-max)))))
  (if (null? root)
      0
      (helper root (node-val root) (node-val root))))

(define (node-val node) (vector-ref node 0))
(define (node-left node) (vector-ref node 1))
(define (node-right node) (vector-ref node 2))