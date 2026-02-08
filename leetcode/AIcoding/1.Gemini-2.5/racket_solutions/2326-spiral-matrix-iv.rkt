(struct ListNode (val next))

(define (spiralMatrix m n head)
  (define matrix (build-vector m (lambda (i) (build-vector n (lambda (j) -1)))))
  (define top 0)
  (define bottom (- m 1))
  (define left 0)
  (define right (- n 1))
  (define current-node head)

  (let loop ()
    (when (and (<= top bottom) (<= left right))
      (when current-node
        (for ([j (in-range left (+ right 1))])
          (when current-node
            (vector-set! (vector-ref matrix top) j (ListNode-val current-node))
            (set! current-node (ListNode-next current-node)))))
      (set! top (+ top 1))

      (when (and current-node (<= top bottom))
        (for ([i (in-range top (+ bottom 1))])
          (when current-node
            (vector-set! (vector-ref matrix i) right (ListNode-val current-node))
            (set! current-node (ListNode-next current-node)))))
      (set! right (- right 1))

      (when (and current-node (<= top bottom) (<= left right))
        (for ([j (in-range right (- left 1) -1)])
          (when current-node
            (vector-set! (vector-ref matrix bottom) j (ListNode-val current-node))
            (set! current-node (ListNode-next current-node)))))
      (set! bottom (- bottom 1))

      (when (and current-node (<= top bottom) (<= left right))
        (for ([i (in-range bottom (- top 1) -1)])
          (when current-node
            (vector-set! (vector-ref matrix i) left (ListNode-val current-node))
            (set! current-node (ListNode-next current-node)))))
      (set! left (+ left 1))

      (loop)))

  (for/list ([row (in-vector matrix)])
    (for/list ([val (in-vector row)])
      val)))