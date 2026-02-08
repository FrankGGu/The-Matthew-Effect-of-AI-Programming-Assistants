(define (minCost h v horizontal vertical)
  (define h-cuts (sort horizontal <))
  (define v-cuts (sort vertical <))
  (define h-cuts-padded (cons 0 (append h-cuts (list h))))
  (define v-cuts-padded (cons 0 (append v-cuts (list v))))

  (define (solve h-cuts-padded v-cuts-padded)
    (define h-len (length h-cuts-padded))
    (define v-len (length v-cuts-padded))

    (define dp (make-vector h-len (make-vector v-len 0)))

    (for ([i (in-range (- h-len 2) -1 -1)])
      (for ([j (in-range (- v-len 2) -1 -1)])
        (define horz-cost
          (+ (- (list-ref h-cuts-padded (+ i 2)) (list-ref h-cuts-padded i))
             (vector-ref (vector-ref dp (+ i 2)) j)))
        (define vert-cost
          (+ (- (list-ref v-cuts-padded (+ j 2)) (list-ref v-cuts-padded j))
             (vector-ref (vector-ref dp i) (+ j 2))))
        (vector-set! (vector-ref dp i) j (min horz-cost vert-cost))))

    (vector-ref (vector-ref dp 0) 0))

  (solve h-cuts-padded v-cuts-padded))