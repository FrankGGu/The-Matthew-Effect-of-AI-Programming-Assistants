#lang racket

(define (distance-k root target k)
  (define (build-parent-map node parent map)
    (if (not node)
        map
        (build-parent-map (node-left node) node (hash-set map node parent))))

  (define (get-target-path node path)
    (cond [(not node) #f]
          [(equal? node target) (reverse path)]
          [else
           (or (get-target-path (node-left node) (cons node path))
               (get-target-path (node-right node) (cons node path)))]))

  (define (bfs start-node k)
    (define (helper queue visited result)
      (cond [(null? queue) result]
            [else
             (define current (car queue))
             (define next (cdr queue))
             (if (= k 0)
                 (append result (list current))
                 (helper (append next (filter (lambda (n) (not (hash-has-key? visited n)))
                                              (remove-duplicates (append (if (node-left current) (list (node-left current)) '())
                                                                       (if (node-right current) (list (node-right current)) '())
                                                                       (if (hash-has-key? parent-map current) (list (hash-ref parent-map current)) '()))))
                        (hash-set visited current #t)
                        (if (> k 0) result (append result (list current))))]))
    (helper (list start-node) (hash) '()))

  (define parent-map (build-parent-map root #f (hash)))
  (define target-path (get-target-path root '()))
  (if (not target-path)
      '()
      (let ([result (bfs target k)])
        (if (= k 0)
            (list target)
            result))))