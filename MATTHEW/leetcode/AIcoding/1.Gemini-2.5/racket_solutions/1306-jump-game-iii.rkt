(require racket/hash)

(define/public (can-reach arr start)
  (define n (vector-length arr))
  (define visited (make-hash-set))

  (define (dfs current-idx)
    (cond
      ((or (< current-idx 0) (>= current-idx n)) #f)
      ((hash-set-contains? visited current-idx) #f)
      ((= (vector-ref arr current-idx) 0) #t)
      (else
       (hash-set-add! visited current-idx)
       (define jump-val (vector-ref arr current-idx))
       (define left-idx (- current-idx jump-val))
       (define right-idx (+ current-idx jump-val))
       (or (dfs left-idx)
           (dfs right-idx))))))

  (dfs start))