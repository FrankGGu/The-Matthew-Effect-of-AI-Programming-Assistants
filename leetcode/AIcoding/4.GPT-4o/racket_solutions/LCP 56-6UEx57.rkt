(define (can-transfer n k)
  (define (helper current k visited)
    (if (= current n) 
        #t
        (for/or ([i (in-range (max 1 (- current k)) (min n (+ current k 1)))])
          (and (not (vector-ref visited i))
               (begin
                 (vector-set! visited i #t)
                 (helper i k visited)))))
  (let ([visited (make-vector (+ n 1) #f)])
    (vector-set! visited 1 #t)
    (helper 1 k visited)))

(define (main)
  (define inputs (list (list 5 2) (list 6 1)))
  (for ([input inputs])
    (define n (first input))
    (define k (second input))
    (display (can-transfer n k))
    (newline)))

(main)