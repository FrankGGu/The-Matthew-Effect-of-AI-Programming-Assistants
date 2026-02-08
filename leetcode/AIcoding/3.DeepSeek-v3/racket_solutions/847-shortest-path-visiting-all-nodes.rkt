(define/contract (shortest-path-length graph)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length graph)]
         [target (sub1 (arithmetic-shift 1 n))]
         [queue (make-queue)]
         [visited (make-hash)])
    (for ([i (in-range n)])
      (hash-set! visited (cons i (arithmetic-shift 1 i)) 0)
      (enqueue! queue (cons i (arithmetic-shift 1 i))))
    (let loop ()
      (if (queue-empty? queue)
          -1
          (let* ([current (dequeue! queue)]
                 [node (car current)]
                 [mask (cdr current)]
                 [dist (hash-ref visited current)])
            (if (= mask target)
                dist
                (begin
                  (for ([neighbor (in-list (list-ref graph node))])
                    (let* ([new-mask (bitwise-ior mask (arithmetic-shift 1 neighbor))]
                           [new-state (cons neighbor new-mask)])
                      (when (or (not (hash-has-key? visited new-state))
                                (< (add1 dist) (hash-ref visited new-state)))
                        (hash-set! visited new-state (add1 dist))
                        (enqueue! queue new-state))))
                  (loop)))))))