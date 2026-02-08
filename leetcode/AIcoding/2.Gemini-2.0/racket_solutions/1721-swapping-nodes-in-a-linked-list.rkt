(define (swap-nodes head k)
  (let* ((len (let loop ((node head) (count 0))
                 (if (null? node)
                     count
                     (loop (cdr node) (+ count 1)))))
         (first-node (let loop ((node head) (count 1))
                        (if (= count k)
                            node
                            (loop (cdr node) (+ count 1)))))
         (second-node (let loop ((node head) (count 1))
                         (if (= count (- len k) 1)
                             node
                             (loop (cdr node) (+ count 1)))))
         (first-val (car first-node))
         (second-val (car second-node)))
    (set-car! first-node second-val)
    (set-car! second-node first-val)
    head))