(define/contract (can-reach arr start)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let ([n (length arr)]
        [visited (make-vector n #f)])
    (define (dfs pos)
      (cond
        [(or (< pos 0) (>= pos n)) #f]
        [(vector-ref visited pos) #f]
        [(zero? (list-ref arr pos)) #t]
        [else
         (vector-set! visited pos #t)
         (or (dfs (+ pos (list-ref arr pos)))
             (dfs (- pos (list-ref arr pos))))]))
    (dfs start)))