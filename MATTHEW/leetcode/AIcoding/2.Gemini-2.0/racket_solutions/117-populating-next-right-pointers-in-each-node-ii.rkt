(define (connect root)
  (define (helper node)
    (if (null? node)
        #f
        (begin
          (define next-right (find-next-right node))
          (set-struct-field! node 'next next-right)
          (helper (struct-field node 'left))
          (helper (struct-field node 'right)))))

  (define (find-next-right node)
    (let loop ([current (struct-field node 'parent)])
      (cond
        [(null? current) #f]
        [else
         (cond
           [(eq? (struct-field current 'left) node)
            (cond
              [(not (null? (struct-field current 'right))) (struct-field current 'right)]
              [else (find-next-level (struct-field current 'parent))])]
           [else
            (find-next-level (struct-field current 'parent))])])))

  (define (find-next-level node)
    (let loop ([current node])
      (cond
        [(null? current) #f]
        [else
         (or (and (not (null? (struct-field current 'left))) (struct-field current 'left))
             (and (not (null? (struct-field current 'right))) (struct-field current 'right))
             (loop (struct-field current 'next)))])))

  (helper root)
  root)