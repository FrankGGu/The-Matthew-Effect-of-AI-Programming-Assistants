(define (smallest-from-leaf root)
  (define (dfs node path)
    (cond
      [(null? node) #f]
      [(and (null? (-> node 'left)) (null? (-> node 'right)))
       (list->string (reverse (cons (integer->char (+ 97 (-> node 'val))) path)))]
      [else
       (let ([left-result (and (-> node 'left) (dfs (-> node 'left) (cons (integer->char (+ 97 (-> node 'val))) path)))]
             [right-result (and (-> node 'right) (dfs (-> node 'right) (cons (integer->char (+ 97 (-> node 'val))) path)))])
         (cond
           [(and left-result right-result) (min left-result right-result)]
           [left-result left-result]
           [right-result right-result]
           [else #f]))]))
  (dfs root '()))