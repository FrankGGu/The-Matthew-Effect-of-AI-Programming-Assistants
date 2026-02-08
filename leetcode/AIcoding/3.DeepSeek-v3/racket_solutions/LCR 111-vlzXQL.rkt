(define (calc-equation equations values queries)
  (let* ([graph (make-hash)]
         [build-graph
          (lambda ()
            (for ([eq equations] [val values])
              (let ([u (car eq)] [v (cadr eq)])
              (hash-update! graph u (lambda (lst) (cons (cons v val) lst)) '())
              (hash-update! graph v (lambda (lst) (cons (cons u (/ 1 val)) lst)) '())))])
    [dfs 
     (lambda (start end visited)
       (cond
         [(not (hash-has-key? graph start)) -1.0]
         [(equal? start end) 1.0]
         [else
          (hash-set! visited start #t)
          (let ([res -1.0])
            (for ([neighbor (hash-ref graph start '())])
              (let ([node (car neighbor)] [weight (cdr neighbor)])
                (when (not (hash-has-key? visited node))
                  (let ([path-weight (dfs node end visited)])
                    (when (> path-weight 0)
                      (set! res (* weight path-weight)))))))
            (hash-remove! visited start)
            (if (> res 0) res -1.0))])])
    (build-graph)
    (map (lambda (query)
           (let ([start (car query)] [end (cadr query)])
             (dfs start end (make-hash))))
         queries)))