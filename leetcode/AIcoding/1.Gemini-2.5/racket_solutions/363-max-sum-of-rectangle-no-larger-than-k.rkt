#lang racket/base

(require data/red-black-tree)

(define (max-sum-submatrix matrix k)
  (let* ([rows (vector-length matrix)]
         [cols (if (> rows 0) (vector-length (vector-ref matrix 0)) 0)])

    (let ([max-sum -inf.0])

      (let* ([is-transposed? (> rows cols)]
             [m (if is-transposed? cols rows)]
             [n (if is-transposed? rows cols)]
             [mat (if is-transposed?
                      (for/vector ([j (in-range n)])
                        (for/vector ([i (in-range m)])
                          (vector-ref (vector-ref matrix i) j)))
                      matrix)])

        (for ([r1 (in-range m)])
          (let ([row-sums (make-vector n 0)])
            (for ([r2 (in-range r1 m)])
              (for ([c (in-range n)])
                (vector-set! row-sums c
                             (+ (vector-ref row-sums c)
                                (vector-ref (vector-ref mat r2) c))))

              (let ([current-prefix-sum 0]
                    [prefix-sums-tree (rbt-insert (rbt-empty <) 0 #t)])
                (for ([val (in-vector row-sums)])
                  (set! current-prefix-sum (+ current-prefix-sum val))

                  (let ([target-p (- current-prefix-sum k)])
                    (let ([found-node (rbt-find-next prefix-sums-tree target-p)])
                      (when found-node
                        (let ([p-val (rbt-node-key found-node)])
                          (set! max-sum (max max-sum (- current-prefix-sum p-val)))))))

                  (set! prefix-sums-tree (rbt-insert prefix-sums-tree current-prefix-sum #t)))))))
        max-sum))))