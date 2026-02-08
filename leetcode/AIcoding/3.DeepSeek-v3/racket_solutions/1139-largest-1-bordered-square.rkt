(define/contract (largest1BorderedSquare grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define left (make-vector rows (make-vector cols 0)))
  (define top (make-vector rows (make-vector cols 0)))
  (define max-side 0)

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (if (positive? (list-ref (list-ref grid i) j))
          (begin
            (vector-set! (vector-ref left i) j (if (zero? j) 1 (+ 1 (vector-ref (vector-ref left i) (- j 1)))))
            (vector-set! (vector-ref top i) j (if (zero? i) 1 (+ 1 (vector-ref (vector-ref top (- i 1)) j))))
            (set! max-side (max max-side 1)))
          (begin
            (vector-set! (vector-ref left i) j 0)
            (vector-set! (vector-ref top i) j 0)))))

  (for ([i (in-range 1 rows)])
    (for ([j (in-range 1 cols)])
      (let loop ([side (min (vector-ref (vector-ref left i) j) (vector-ref (vector-ref top i) j))])
        (when (> side max-side)
          (let ([min-top (min (vector-ref (vector-ref top i) (- j side -1)))]
                [min-left (min (vector-ref (vector-ref left (- i side -1)) j))])
            (when (and (>= min-top side) (>= min-left side))
              (set! max-side side)))
          (loop (- side 1))))))

  (* max-side max-side))