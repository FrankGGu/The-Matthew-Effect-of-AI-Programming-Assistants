(define (most-profitable-path n edges bob amount)
  (define adj (make-vector n null))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define bob-dist (make-vector n n))
  (vector-set! bob-dist bob 0)

  (define q (list bob))
  (define q-tail q)

  (define (enqueue! item)
    (if (null? q-tail)
        (begin
          (set! q (list item))
          (set! q-tail q))
        (begin
          (set-cdr! q-tail (list item))
          (set! q-tail (cdr q-tail)))))

  (define (dequeue!)
    (let ((item (car q)))
      (set! q (cdr q))
      (when (null? q) (set! q-tail null))
      item))

  (define (queue-empty?) (null? q))

  (let bfs-loop ()
    (unless (queue-empty?)
      (let* ((u (dequeue!))
             (d (vector-ref bob-dist u)))
        (for-each (lambda (v)
                    (when (= (vector-ref bob-dist v) n)
                      (vector-set! bob-dist v (+ d 1))
                      (enqueue! v)))
                  (vector-ref adj u)))
      (bfs-loop)))

  (define max-profit (- (expt 10 10)))

  (define (dfs u parent alice-depth current-sum)
    (let* ((node-amount (vector-ref amount u))
           (bob-arrival-depth (vector-ref bob-dist u))
           (effective-amount node-amount))
      (cond
        ((< alice-depth bob-arrival-depth)
         )
        ((= alice-depth bob-arrival-depth)
         (set! effective-amount (quotient node-amount 2)))
        ((> alice-depth bob-arrival-depth)
         (set! effective-amount 0)))

      (let ((new-sum (+ current-sum effective-amount)))
        (let ((is-leaf? #t))
          (for-each (lambda (v)
                      (when (not (= v parent))
                        (set! is-leaf? #f)
                        (dfs v u (+ alice-depth 1) new-sum)))
                    (vector-ref adj u))
          (when is-leaf?
            (set! max-profit (max max-profit new-sum)))))))

  (dfs 0 -1 0 0)
  max-profit)