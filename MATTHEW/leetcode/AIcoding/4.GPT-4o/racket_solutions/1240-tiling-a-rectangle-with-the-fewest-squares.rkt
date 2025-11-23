(define (min-squares n m)
  (define (dp w h)
    (if (or (= w 0) (= h 0)) 0
        (if (and (<= w 1) (<= h 1)) 1
            (if (memo? (list w h))
                (memo-ref (list w h))
                (begin
                  (define best (infinity))
                  (for ([i (in-range 1 (+ 1 (min w h)))])
                    (set! best (min best (max (dp i h) (dp w (- h i)) (dp (- w i) h) (dp w h)))))
                  (memo-set! (list w h) (+ best 1))
                  (+ best 1))))))
  (let ([memo (make-hash)])
    (define (memo? key) (hash-has-key? memo key))
    (define (memo-ref key) (hash-ref memo key))
    (define (memo-set! key value) (hash-set! memo key value))
    (dp n m)))

(define (tiling-rectangle n m)
  (min-squares n m))

(tiling-rectangle 11 13)