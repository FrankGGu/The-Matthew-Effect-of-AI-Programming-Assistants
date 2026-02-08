(define/contract (count-visited-nodes edges)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length edges)]
         [res (make-vector n 0)]
         [visited (make-vector n -1)]
         [in-cycle (make-vector n #f)])
    (for ([i (in-range n)])
    (define (dfs u step)
      (cond
        [(>= (vector-ref visited u) 0)
         (let ([cycle-length (- step (vector-ref visited u))])
         (when (> cycle-length 0)
           (for ([v (in-range n)] #:when (vector-ref in-cycle v))
             (vector-set! res v cycle-length)))
         (sub1 step)]
        [else
         (vector-set! visited u step)
         (vector-set! in-cycle u #t)
         (let ([ret (dfs (list-ref edges u) (add1 step))])
           (vector-set! in-cycle u #f)
           (if (vector-ref res u)
               ret
               (begin
                 (vector-set! res u (add1 (vector-ref res (list-ref edges u))))
                 ret))))]))
    (for ([i (in-range n)] #:when (= (vector-ref visited i) -1))
      (dfs i 0))
    (vector->list res)))