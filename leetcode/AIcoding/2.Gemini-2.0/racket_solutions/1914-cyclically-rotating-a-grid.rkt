(define (rotateGrid grid k)
  (define m (length grid))
  (define n (length (car grid)))
  (define layers (min (/ m 2) (/ n 2)))

  (define (rotate-layer layer)
    (define (get-val i j)
      (list-ref (list-ref grid i) j))
    (define (set-val! i j val)
      (set! (list-ref (list-ref grid i) j) val))

    (define layer-width (- n (* 2 layer)))
    (define layer-height (- m (* 2 layer)))
    (define perimeter (+ (* 2 layer-width) (* 2 layer-height) -4))

    (define rotations (modulo k perimeter))

    (define (rotate-once)
      (define temp (get-val layer layer))

      ; Top row
      (for ((j (in-range layer (+ layer layer-width -1))))
        (set-val! layer j (get-val layer (+ j 1))))

      ; Right column
      (for ((i (in-range layer (+ layer layer-height -1))))
        (set-val! i (+ layer layer-width -1) (get-val (+ i 1) (+ layer layer-width -1))))

      ; Bottom row
      (for ((j (in-range (+ layer layer-width -1) layer -1)))
        (set-val! (+ layer layer-height -1) j (get-val (+ layer layer-height -1) (- j 1))))

      ; Left column
      (for ((i (in-range (+ layer layer-height -1) layer -1)))
        (set-val! i layer (get-val (- i 1) layer)))

      (set-val! (+ layer 1) layer temp))

    (for ((i (in-range rotations)))
      (rotate-once)))

  (for ((i (in-range layers)))
    (rotate-layer i))

  grid)