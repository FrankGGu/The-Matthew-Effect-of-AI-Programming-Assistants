(define/contract (is-valid-bst root)
  (-> (or/c null? (list/c integer? (or/c null? (list/c any/c)) (or/c null? (list/c any/c))) boolean?)
  (let loop ([node root] [lower -inf.0] [upper +inf.0])
    (cond
      [(null? node) #t]
      [(or (not (real? (car node))) 
           (<= (car node) lower) 
           (>= (car node) upper)) #f]
      [else (and (loop (cadr node) lower (car node))
                 (loop (caddr node) (car node) upper))])))