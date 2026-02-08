(define (knight-probability n k row column)
  (define knight-moves
    '((2 1) (2 -1) (-2 1) (-2 -1)
      (1 2) (1 -2) (-1 2) (-1 -2)))

  (define (on-board? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))

  ;; Helper to create a 2D mutable vector
  (define (make-2d-mutable-vector rows cols initial-value)
    (build-vector rows (lambda (r) (make-vector cols initial-value))))

  (define current-dp (make-2d-mutable-vector n n 0.0))
  (vector-set! (vector-ref current-dp row) column 1.0)

  (for ([step (in-range k)])
    (define next-dp (make-2d-mutable-vector n n 0.0))
    (for ([r (in-range n)])
      (for ([c (in-range n)])
        (define prob (vector-ref (vector-ref current-dp r) c))
        (when (> prob 0.0)
          (for-each (lambda (move)
                      (define dr (car move))
                      (define dc (cdr move))
                      (define next-r (+ r dr))
                      (define next-c (+ c dc))
                      (when (on-board? next-r next-c)
                        (vector-set! (vector-ref next-dp next-r) next-c
                                     (+ (vector-ref (vector-ref next-dp next-r) next-c)
                                        (/ prob 8.0)))))
                    knight-moves))))
    (set! current-dp next-dp))

  (define total-probability 0.0)
  (for ([r (in-range n)])
    (for ([c (in-range n)])
      (set! total-probability (+ total-probability (vector-ref (vector-ref current-dp r) c)))))
  total-probability)