(define (possible-bipartition n dislikes)
  (define adj (make-vector (add1 n) '()))
  (for ([d dislikes])
    (let ([u (car d)] [v (cadr d)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v))))
    )

  (define color (make-vector (add1 n) 0))

  (define (dfs u c)
    (vector-set! color u c)
    (for ([v (vector-ref adj u)])
      (cond
        [(= (vector-ref color v) c) #f]
        [(= (vector-ref color v) 0) (unless (dfs v (- 3 c)) #f)]
        )
      )
    #t
    )

  (for/and ([i (in-range 1 (add1 n))])
    (cond
      [(= (vector-ref color i) 0) (dfs i 1)]
      [else #t]
      )
    )
  )