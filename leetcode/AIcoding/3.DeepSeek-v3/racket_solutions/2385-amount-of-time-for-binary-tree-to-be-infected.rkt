#lang racket

(define (amount-of-time root start)
  (define (build-graph node parent graph)
    (if (null? node)
        graph
        (let* ([val (car node)]
               [left (cadr node)]
               [right (caddr node)]
               [new-graph (hash-set graph val (set))])
          (if (not (null? parent))
              (let* ([new-graph (hash-set new-graph val (set-add (hash-ref new-graph val (set)) parent))]
                     [new-graph (hash-set new-graph parent (set-add (hash-ref new-graph parent (set)) val))])
                (build-graph right val (build-graph left val new-graph)))
              (build-graph right val (build-graph left val new-graph))))))

  (define graph (build-graph root null (hash)))

  (define (bfs start)
    (let loop ([queue (list start)]
               [visited (set)]
               [time -1])
      (if (null? queue)
          time
          (let ([new-queue '()])
            (for ([node (in-list queue)])
              (set! visited (set-add visited node))
              (for ([neighbor (in-set (hash-ref graph node (set)))])
                (unless (set-member? visited neighbor)
                  (set! new-queue (cons neighbor new-queue)))))
            (loop (reverse new-queue) visited (add1 time))))))

  (bfs start))