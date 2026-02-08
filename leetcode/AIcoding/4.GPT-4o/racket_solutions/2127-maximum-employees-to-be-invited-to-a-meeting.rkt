(define (max-invitations pairs)
  (define n (length pairs))
  (define adj (make-vector n '()))
  (for ([i (in-range n)])
    (let ([x (car (list-ref pairs i))] )
          [y (cdr (list-ref pairs i))])
      (vector-set! adj x (cons y (vector-ref adj x)))))

  (define (dfs visited node)
    (set! visited (set-add visited node))
    (for ([neighbor (vector-ref adj node)])
      (unless (set-member? visited neighbor)
        (dfs visited neighbor)))
    visited)

  (define count-invitations
    (lambda (visited)
      (for/fold ([count 0]) ([i (in-range n)])
        (if (set-member? visited i)
            count
            (+ count 1)))))

  (define max-count
    (for/fold ([count 0]) ([i (in-range n)])
      (let ([visited (set)])
        (if (set-member? visited i)
            count
            (let ([new-visited (dfs visited i)])
              (max count (count-invitations new-visited)))))))
  max-count)

(max-invitations '((0 . 1) (1 . 2) (2 . 0) (3 . 4) (4 . 5) (5 . 3)))