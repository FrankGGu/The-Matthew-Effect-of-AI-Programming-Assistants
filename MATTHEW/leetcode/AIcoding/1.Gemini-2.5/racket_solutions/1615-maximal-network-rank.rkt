(define (maximal-network-rank n roads)
  (define degrees (make-vector n 0))
  (define adj-matrix (make-vector n))
  (for ([i (in-range n)])
    (vector-set! adj-matrix i (make-vector n #f)))

  (for ([road roads])
    (define city1 (car road))
    (define city2 (cadr road))

    (vector-set! degrees city1 (add1 (vector-ref degrees city1)))
    (vector-set! degrees city2 (add1 (vector-ref degrees city2)))

    (vector-set! (vector-ref adj-matrix city1) city2 #t)
    (vector-set! (vector-ref adj-matrix city2) city1 #t))

  (define max-rank 0)
  (for ([i (in-range n)])
    (for ([j (in-range (add1 i) n)])
      (define deg-i (vector-ref degrees i))
      (define deg-j (vector-ref degrees j))

      (define current-rank (+ deg-i deg-j))

      (when (vector-ref (vector-ref adj-matrix i) j)
        (set! current-rank (sub1 current-rank)))

      (set! max-rank (max max-rank current-rank))))

  max-rank)