(define/contract (all-paths-source-target graph)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let loop ([node 0] [path '(0)] [result '()])
    (if (= node (- (length graph) 1))
        (cons (reverse path) result)
        (foldl (lambda (next res)
                 (loop next (cons next path) res))
               result
               (list-ref graph node)))))