(define (all-recipes recipes ingredients supplies)
  (define recipe-graph (make-hash))
  (define indegrees (make-hash))
  (define result '())

  (for ([recipe recipes] [ingredients-list ingredients])
    (hash-set! recipe-graph recipe ingredients-list)
    (hash-set! indegrees recipe (length ingredients-list)))

  (define queue (list))
  (for ([supply supplies])
    (when (hash-has-key? indegrees supply)
      (hash-remove! indegrees supply))
    (set! queue (append queue (list supply))))

  (define (process-queue q)
    (cond
      [(empty? q) #t]
      [else
       (let ([curr (car q)])
         (set! q (cdr q))
         (for ([recipe recipes])
           (when (hash-has-key? indegrees recipe)
             (let ([ingredients (hash-ref recipe-graph recipe)])
               (when (member curr ingredients)
                 (hash-update! indegrees recipe sub1 0)
                 (when (= (hash-ref indegrees recipe) 0)
                   (hash-remove! indegrees recipe)
                   (set! result (append result (list recipe)))
                   (set! q (append q (list recipe))))))))
         (process-queue q))]))

  (process-queue queue)

  (cond
    [(empty? (hash-keys indegrees))
     (sort result string<?)]
    [else
     '()]))