(define (find-mode root)
  (define modes '())
  (define max-count 0)
  (define current-count 0)
  (define prev-value #f)

  (define (in-order-traversal node)
    (if (null? node) 
        '()
        (begin
          (in-order-traversal (node-left node))
          (let ((current-value (node-val node)))
            (if (equal? current-value prev-value)
                (set! current-count (+ current-count 1))
                (begin
                  (set! current-count 1)
                  (set! prev-value current-value)))
            (if (= current-count max-count)
                (set! modes (cons current-value modes))
                (if (> current-count max-count)
                    (begin
                      (set! max-count current-count)
                      (set! modes (list current-value)))))
            (in-order-traversal (node-right node)))))

  (in-order-traversal root)
  (reverse modes))