(define (longest-special-path n graph)
  (define adj (make-vector n '()))
  (for/list ([i (in-range (vector-length graph))])
    (for/list ([j (in-range (vector-length (vector-ref graph i)))])
      (vector-set! adj i (append (vector-ref adj i) (list (list (vector-ref (vector-ref graph i) j) j))))))

  (define (dfs node visited)
    (let loop ([neighbors (vector-ref adj node)]
               [max-len 0])
      (cond
        [(null? neighbors) max-len]
        [else
         (let* ([neighbor (car neighbors)]
                [color (car neighbor)]
                [next-node (cadr neighbor)])
           (if (or (member next-node visited) (= color (vector-ref color-map node)))
               (loop (cdr neighbors) max-len)
               (loop (cdr neighbors) (max max-len (+ 1 (dfs next-node (cons node visited)))))))])))

  (define color-map (make-vector n #f))
  (for/list ([i (in-range (vector-length graph))])
    (vector-set! color-map i (car (vector-ref graph i))))

  (let loop ([node 0]
             [max-path 0])
    (if (= node n)
        max-path
        (loop (+ node 1) (max max-path (dfs node '()))))))