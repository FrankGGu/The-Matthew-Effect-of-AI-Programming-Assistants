(require racket/vector)
(require racket/queue)
(require racket/hash)

(define (sort-items n m group beforeItems)
  (define current-group (make-vector n 0))
  (vector-copy! current-group 0 group)

  (define next-group-id m)
  (for ([i (in-range n)])
    (when (= (vector-ref current-group i) -1)
      (vector-set! current-group i next-group-id)
      (set! next-group-id (+ next-group-id 1))))
  (define num-groups next-group-id)

  (define item-adj (make-vector n '()))
  (define item-in-degree (make-vector n 0))
  (define group-adj (make-vector num-groups '()))
  (define group-in-degree (make-vector num-groups 0))

  (for ([i (in-range n)])
    (define item-g (vector-ref current-group i))
    (for ([prev-item (vector-ref beforeItems i)])
      (vector-set! item-adj prev-item (cons i (vector-ref item-adj prev-item)))
      (vector-set! item-in-degree i (+ (vector-ref item-in-degree i) 1))

      (define prev-item-g (vector-ref current-group prev-item))
      (when (not (= item-g prev-item-g))
        (vector-set! group-adj prev-item-g (cons item-g (vector-ref group-adj prev-item-g)))
        (vector-set! group-in-degree item-g (+ (vector-ref group-in-degree item-g) 1)))))

  (define (topo-sort num-nodes adj in-degree-vec)
    (define q (make-queue))
    (define current-in-degree (vector-copy in-degree-vec))

    (for ([i (in-range num-nodes)])
      (when (= (vector-ref current-in-degree i) 0)
        (enqueue! q i)))

    (define result '())
    (define visited-count 0)

    (while (not (queue-empty? q))
      (define u (dequeue! q))
      (set! result (cons u result))
      (set! visited-count (+ visited-count 1))

      (for ([v (vector-ref adj u)])
        (vector-set! current-in-degree v (- (vector-ref current-in-degree v) 1))
        (when (= (vector-ref current-in-degree v) 0)
          (enqueue! q v))))

    (if (= visited-count num-nodes)
        (reverse result)
        '()))

  (define sorted-groups (topo-sort num-groups group-adj group-in-degree))
  (when (null? sorted-groups)
    (current-group)
    (num-groups)
    (group-adj)
    (group-in-degree)
    (topo-sort num-groups group-adj group-in-degree)
    '())

  (define sorted-items (topo-sort n item-adj item-in-degree))
  (when (null? sorted-items)
    '())

  (define group-to-sorted-items-map (make-hash))
  (for ([item sorted-items])
    (define g (vector-ref current-group item))
    (hash-set! group-to-sorted-items-map g (cons item (hash-ref group-to-sorted-items-map g '()))))

  (for ([g (hash-keys group-to-sorted-items-map)])
    (hash-set! group-to-sorted-items-map g (reverse (hash-ref group-to-sorted-items-map g))))

  (define lists-to-append '())
  (for ([g sorted-groups])
    (set! lists-to-append (cons (hash-ref group-to-sorted-items-map g '()) lists-to-append)))
  (apply append (reverse lists-to-append)))