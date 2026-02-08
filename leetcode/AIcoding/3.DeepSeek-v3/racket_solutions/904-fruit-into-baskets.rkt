(define/contract (total-fruit fruits)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [max-count 0] [counts (make-hash)] [fruits fruits])
    (cond
      [(>= right (length fruits)) max-count]
      [else
       (let* ([fruit (list-ref fruits right)]
              [counts (hash-update counts fruit add1 (lambda () 0))])
         (let inner-loop ()
           (cond
             [(> (hash-count counts) 2)
              (let* ([left-fruit (list-ref fruits left)]
                     [counts (hash-update counts left-fruit sub1)]
                     [counts (if (zero? (hash-ref counts left-fruit))
                                  (hash-remove counts left-fruit)
                                  counts)])
                (inner-loop (add1 left)))]
             [else
              (loop left (add1 right) (max max-count (- (add1 right) left)) counts fruits)])))])))