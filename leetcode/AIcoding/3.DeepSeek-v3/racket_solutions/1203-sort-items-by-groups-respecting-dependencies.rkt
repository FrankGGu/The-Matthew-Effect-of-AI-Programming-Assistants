#lang racket

(define (sort-items n m group beforeItems)
  (define (build-graph group beforeItems)
    (define group-graph (make-hash))
    (define item-graph (make-hash))
    (define group-items (make-hash))
    (define group-id m)

    (for ([i (in-range n)])
      (when (= (vector-ref group i) -1)
        (vector-set! group i group-id)
        (set! group-id (add1 group-id))))

    (for ([i (in-range n)])
      (define g (vector-ref group i))
      (hash-update! group-items g (lambda (v) (cons i v)) '()))

    (for ([i (in-range n)])

    (for ([i (in-range n)]
          [deps (in-list beforeItems)])
      (define g-i (vector-ref group i))
      (for ([dep (in-list deps)])
        (define g-dep (vector-ref group dep))
        (unless (= g-i g-dep)
          (hash-update! group-graph g-dep (lambda (v) (cons g-i v)) '()))
        (hash-update! item-graph dep (lambda (v) (cons i v)) '())))

    (values group-graph item-graph group-items group-id))

  (define (topo-sort graph items)
    (define in-degree (make-hash))
    (define q (make-queue))
    (define result '())

    (for ([(node neighbors) (in-hash graph)])
      (hash-set! in-degree node (hash-ref in-degree node 0))
      (for ([neighbor (in-list neighbors)])
        (hash-update! in-degree neighbor add1 0)))

    (for ([(node deg) (in-hash in-degree)])
      (when (zero? deg)
        (enqueue! q node)))

    (while (not (queue-empty? q))
      (define node (dequeue! q))
      (set! result (append result (hash-ref items node '())))
      (for ([neighbor (in-list (hash-ref graph node '()))])
        (hash-update! in-degree neighbor sub1)
        (when (zero? (hash-ref in-degree neighbor))
          (enqueue! q neighbor))))

    (if (= (length result) (hash-count items))
        result
        '()))

  (define-values (group-graph item-graph group-items group-count) (build-graph group beforeItems))
  (define group-order (topo-sort group-graph group-items))
  (if (null? group-order)
      '()
      (let ([result '()])
        (for ([g (in-list group-order)])
          (define items-in-group (hash-ref group-items g))
          (define item-order (topo-sort item-graph (make-hash (list (cons g items-in-group)))))
          (if (null? item-order)
              '()
              (set! result (append result item-order))))
        (if (= (length result) n)
            result
            '()))))