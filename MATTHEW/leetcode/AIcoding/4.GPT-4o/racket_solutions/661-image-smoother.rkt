(define (imageSmoother M)
  (define (in-bounds? r c)
    (and (>= r 0) (< r (length M)) (>= c 0) (< c (length (vector-ref M 0)))))

  (define (get-neighbors r c)
    (for/list ([dr (list -1 0 1)]
               [dc (list -1 0 1)])
      (let ([nr (+ r dr)]
            [nc (+ c dc)])
        (when (in-bounds? nr nc)
          (vector-ref (vector-ref M nr) nc)))))

  (define (smooth-pixel r c)
    (let* ([neighbors (get-neighbors r c)]
           [sum (apply + neighbors)]
           [count (length neighbors)])
      (floor (/ sum count))))

  (define (smooth-image)
    (for/list ([r (in-range (length M))])
      (for/list ([c (in-range (length (vector-ref M r)))])
        (smooth-pixel r c))))

  (smooth-image))