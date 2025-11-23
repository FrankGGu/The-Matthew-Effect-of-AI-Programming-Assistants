(define (restore-array-from-adjacent-pairs adjacentPairs)
  (define graph (make-hash))
  (for-each (lambda (pair)
              (define u (car pair))
              (define v (cadr pair))
              (hash-set! graph u (cons v (hash-ref graph u '())))
              (hash-set! graph v (cons u (hash-ref graph v '()))))
            adjacentPairs)

  (define start #f)
  (for-each (lambda (k v)
              (when (= (length v) 1)
                (set! start k)))
            graph)

  (define array-length (add1 (length adjacentPairs)))

  (define (build-array current previous result-list count)
    (if (= count array-length)
        (reverse result-list)
        (let* ([neighbors (hash-ref graph current)]
               [next (cond
                       [(eq? previous #f) (car neighbors)]
                       [else (if (eq? (car neighbors) previous)
                                 (cadr neighbors)
                                 (car neighbors))])])
          (build-array next current (cons next result-list) (add1 count)))))

  (build-array start #f (list start) 1))