(define (largest-overlap img1 img2)
  (define n (length img1))

  (define (get-ones-coords img)
    (define coords '())
    (for ([r (in-range n)])
      (for ([c (in-range n)])
        (when (= (list-ref (list-ref img r) c) 1)
          (set! coords (cons (list r c) coords)))))
    coords)

  (define coords1 (get-ones-coords img1))
  (define coords2 (get-ones-coords img2))

  (if (or (empty? coords1) (empty? coords2))
      0
      (begin
        (define shift-counts (make-hash))

        (for ([p1 coords1])
          (define r1 (car p1))
          (define c1 (cadr p1))
          (for ([p2 coords2])
            (define r2 (car p2))
            (define c2 (cadr p2))

            (define dr (- r1 r2))
            (define dc (- c1 c2))

            (define shift-vec (cons dr dc))

            (hash-update! shift-counts shift-vec add1 0)))

        (apply max (hash-values shift-counts)))))