(define/contract (furthest-building heights bricks ladders)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([i 0]
             [bricks bricks]
             [ladders ladders]
             [heap (make-heap (lambda (a b) (< a b)))])
    (if (>= i (sub1 (length heights)))
        (sub1 (length heights))
        (let ([diff (- (list-ref heights (add1 i)) (list-ref heights i))])
          (if (<= diff 0)
              (loop (add1 i) bricks ladders heap)
              (begin
                (heap-add! heap diff)
                (if (> (heap-count heap) ladders)
                    (let ([min-diff (heap-remove-min! heap)])
                      (if (>= bricks min-diff)
                          (loop (add1 i) (- bricks min-diff) ladders heap)
                          i))
                    (loop (add1 i) bricks ladders heap))))))))