(define (loud-and-rich richer quiet)
  (let* ((n (length quiet))
         (adj-list (make-vector n '()))
         (result (make-vector n #f)))
    (for ([pair (in-list richer)])
      (let ([a (car pair)]
            [b (cdr pair)])
        (vector-set! adj-list b (cons a (vector-ref adj-list b)))))

    (define (dfs person)
      (cond
        [(vector-ref result person) (vector-ref result person)]
        [else
         (let loop ([neighbors (vector-ref adj-list person)]
                    [min-quiet quiet]
                    [min-person person])
           (cond
             [(null? neighbors)
              (vector-set! result person min-person)
              min-person]
             [else
              (let* ([neighbor (car neighbors)]
                     [neighbor-result (dfs neighbor)])
                (if (< (vector-ref quiet neighbor-result) (vector-ref quiet min-person))
                    (loop (cdr neighbors) quiet neighbor-result)
                    (loop (cdr neighbors) quiet min-person))))])]))

    (for/vector ([i (in-range n)])
      (dfs i))))