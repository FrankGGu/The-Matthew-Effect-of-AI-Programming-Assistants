(define (calc-equation equations values queries)
  (define graph (make-hash))

  (for ([i (in-range (length equations))])
    (define eq-pair (list-ref equations i))
    (define u (first eq-pair))
    (define v (second eq-pair))
    (define val (list-ref values i))

    (unless (hash-has-key? graph u)
      (hash-set! graph u (make-hash)))
    (unless (hash-has-key? graph v)
      (hash-set! graph v (make-hash)))

    (hash-set! (hash-ref graph u) v val)
    (hash-set! (hash-ref graph v) u (/ 1.0 val)))

  (define (dfs start-node end-node current-product visited)
    (cond
      [(or (not (hash-has-key? graph start-node))
           (member start-node visited))
       -1.0]
      [(string=? start-node end-node)
       current-product]
      [else
       (define new-visited (cons start-node visited))
       (define neighbors (hash-ref graph start-node))
       (define result -1.0)
       (for ([(neighbor-node conversion-factor) (in-hash neighbors)])
         (define dfs-res (dfs neighbor-node end-node (* current-product conversion-factor) new-visited))
         (when (not (= dfs-res -1.0))
           (set! result dfs-res)
           (break)))
       result]))

  (define results (make-list (length queries) 0.0))
  (for ([i (in-range (length queries))])
    (define query-pair (list-ref queries i))
    (define query-u (first query-pair))
    (define query-v (second query-pair))

    (define res
      (cond
        [(or (not (hash-has-key? graph query-u))
             (not (hash-has-key? graph query-v)))
         -1.0]
        [(string=? query-u query-v)
         1.0]
        [else
         (dfs query-u query-v 1.0 '())]))

    (set! (list-ref results i) res))
  results)