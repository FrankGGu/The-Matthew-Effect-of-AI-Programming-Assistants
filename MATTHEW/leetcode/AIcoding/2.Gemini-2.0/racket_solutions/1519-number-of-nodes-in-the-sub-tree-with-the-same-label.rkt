(define (count-subtree-nodes label edges n)
  (define adj (make-vector n '()))
  (for ([edge (in-list edges)])
    (vector-set! adj (first edge) (cons (second edge) (vector-ref adj (first edge))))
    (vector-set! adj (second edge) (cons (first edge) (vector-ref adj (second edge)))))

  (define result (make-vector n 0))

  (define (dfs node parent)
    (define counts (make-hash))
    (hash-set! counts (string-ref label node) 1)

    (for ([neighbor (in-list (vector-ref adj node))])
      (when (not (equal? neighbor parent))
        (define child-counts (dfs neighbor node))
        (for ([(char count) (in-hash child-counts)])
          (if (hash-has-key? counts char)
              (hash-update! counts char (lambda (x) (+ x count)))
              (hash-set! counts char count)))))

    (vector-set! result node (hash-ref counts (string-ref label node) 0))
    counts)

  (dfs 0 -1)
  (vector->list result))

(provide count-subtree-nodes)