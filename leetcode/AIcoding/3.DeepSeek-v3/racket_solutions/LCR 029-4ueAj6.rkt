(define/contract (insert head val)
  (-> (or/c null? list-node?) exact-integer? list-node?)
  (define new-node (list-node val))
  (cond
    [(null? head) (set-mcdr! new-node new-node) new-node]
    [else
     (define prev head)
     (define curr (mcdr head))
     (let loop ([prev prev] [curr curr] [stop? #f])
       (cond
         [(or stop? (eq? curr head))
          (set-mcdr! prev new-node)
          (set-mcdr! new-node curr)
          head]
         [(and (<= (mcar prev) val (mcar curr))
          (set-mcdr! prev new-node)
          (set-mcdr! new-node curr)
          head]
         [(and (> (mcar prev) (mcar curr))
          (if (or (>= val (mcar prev)) (<= val (mcar curr)))
           (set-mcdr! prev new-node)
           (set-mcdr! new-node curr)
           head]
          [else (loop curr (mcdr curr) #t])]
         [else (loop curr (mcdr curr) #f)]))]))