(define/contract (trap-rain-water height-map)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (null? height-map) 0
      (let* ([m (length height-map)]
             [n (length (car height-map))]
             [visited (make-hash)]
             [heap (make-heap (λ (a b) (< (third a) (third b))))])
        (for ([i (in-range m)])
          (hash-set! visited (cons i 0) #t)
          (hash-set! visited (cons i (- n 1)) #t)
          (heap-add! heap (list i 0 (list-ref (list-ref height-map i) 0)))
          (heap-add! heap (list i (- n 1) (list-ref (list-ref height-map i) (- n 1)))))
        (for ([j (in-range 1 (- n 1))])
          (hash-set! visited (cons 0 j) #t)
          (hash-set! visited (cons (- m 1) j) #t)
          (heap-add! heap (list 0 j (list-ref (list-ref height-map 0) j)))
          (heap-add! heap (list (- m 1) j (list-ref (list-ref height-map (- m 1)) j))))
        (let loop ([res 0]
                   [max-height 0])
          (if (heap-empty? heap) res
              (let* ([cell (heap-remove! heap)]
                     [i (first cell)]
                     [j (second cell)]
                     [h (third cell)]
                     [max-height (max max-height h)])
                (for ([dir (list (list 1 0) (list -1 0) (list 0 1) (list 0 -1))])
                  (let ([ni (+ i (first dir))]
                        [nj (+ j (second dir))])
                    (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                          (not (hash-ref visited (cons ni nj) #f)))
                      (hash-set! visited (cons ni nj) #t)
                      (let ([nh (list-ref (list-ref height-map ni) nj)])
                        (if (< nh max-height)
                            (set! res (+ res (- max-height nh)))
                            (void))
                        (heap-add! heap (list ni nj nh))))))
                (loop res max-height)))))))