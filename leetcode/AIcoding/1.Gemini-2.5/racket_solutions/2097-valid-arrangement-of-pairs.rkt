(define (valid-arrangement pairs)
  (define adj (make-hash))
  (define in-degree (make-hash))
  (define out-degree (make-hash))
  (define all-nodes (make-hash))

  (for-each (lambda (pair)
              (define u (car pair))
              (define v (cadr pair))

              (hash-set! adj u (cons v (hash-ref adj u '())))

              (hash-set! out-degree u (+ (hash-ref out-degree u 0) 1))

              (hash-set! in-degree v (+ (hash-ref in-degree v 0) 1))

              (hash-set! all-nodes u #t)
              (hash-set! all-nodes v #t))
            pairs)

  (define start-node (car (car pairs)))
  (for-each (lambda (node)
              (define out-d (hash-ref out-degree node 0))
              (define in-d (hash-ref in-degree node 0))
              (when (> out-d in-d)
                (set! start-node node)))
            (hash-keys all-nodes))

  (define path '())
  (define stack (list start-node))

  (let loop ()
    (unless (empty? stack)
      (define u (car stack))
      (define neighbors (hash-ref adj u '()))
      (if (empty? neighbors)
          (begin
            (set! path (cons u path))
            (set! stack (cdr stack)))
          (begin
            (define v (car neighbors))
            (hash-set! adj u (cdr neighbors))
            (set! stack (cons v stack))))
      (loop)))

  (define ordered-nodes (reverse path))

  (define result-pairs '())
  (let make-pairs-loop ((nodes ordered-nodes))
    (unless (or (empty? nodes) (empty? (cdr nodes)))
      (set! result-pairs (cons (list (car nodes) (cadr nodes)) result-pairs))
      (make-pairs-loop (cdr nodes))))

  (reverse result-pairs))