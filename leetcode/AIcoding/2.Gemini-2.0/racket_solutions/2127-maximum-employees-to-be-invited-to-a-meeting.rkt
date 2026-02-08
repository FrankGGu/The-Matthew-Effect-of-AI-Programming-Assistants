(define (maximum-invitations circles)
  (define n (vector-length circles))
  (define adj (make-vector n '()))
  (define in-degree (make-vector n 0))
  (for/vector ([i (in-range n)])
    (let ([j (vector-ref circles i)])
      (vector-set! adj i (cons j (vector-ref adj i)))
      (vector-set! in-degree j (+ 1 (vector-ref in-degree j)))))

  (define q (list))
  (define dp (make-vector n 0))
  (for ([i (in-range n)])
    (when (= 0 (vector-ref in-degree i))
      (set! q (append q (list i)))))

  (define chain-sum 0)
  (define non-chain-edges '())

  (define (bfs u)
    (let loop ([q q])
      (cond
        [(empty? q) (void)]
        [else
         (let ([curr (car q)])
           (set! q (cdr q))
           (for ([neighbor (vector-ref adj curr)])
             (when (> (vector-ref in-degree neighbor) 0)
               (vector-set! in-degree neighbor (- (vector-ref in-degree neighbor) 1))
               (when (= (vector-ref circles neighbor) curr)
                 (set! non-chain-edges (cons (cons curr neighbor) non-chain-edges)))
               (vector-set! dp neighbor (add1 (vector-ref dp curr)))
               (when (= 0 (vector-ref in-degree neighbor))
                 (set! q (append q (list neighbor)))))))
         (loop q)])))

  (bfs q)

  (for ([edge non-chain-edges])
    (let* ([u (car edge)]
           [v (cdr edge)])
      (set! chain-sum (+ chain-sum (+ 2 (vector-ref dp u) (vector-ref dp v))))))

  (define visited (make-vector n #f))
  (define (dfs u)
    (vector-set! visited u #t)
    (let ([v (vector-ref circles u)])
      (if (not (vector-ref visited v))
          (+ 1 (dfs v))
          0)))

  (define max-cycle 0)
  (for ([i (in-range n)])
    (when (and (not (vector-ref visited i))
               (= (vector-ref circles (vector-ref circles i)) i))
      (set! max-cycle (+ max-cycle (dfs i)))))

  (max chain-sum max-cycle))