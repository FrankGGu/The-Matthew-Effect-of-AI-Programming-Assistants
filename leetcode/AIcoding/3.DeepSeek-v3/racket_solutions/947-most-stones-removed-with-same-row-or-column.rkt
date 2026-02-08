(define (remove-stones stones)
  (let* ([n (length stones)]
         [parent (make-vector (* n 2) -1)]
         [rank (make-vector (* n 2) 0)]
         [find (lambda (x)
                 (if (= (vector-ref parent x) -1)
                     x
                     (let ([res (find (vector-ref parent x))])
                       (vector-set! parent x res)
                       res)))]
         [union (lambda (x y)
                  (let ([x-root (find x)]
                        [y-root (find y)])
                    (if (not (= x-root y-root))
                        (if (< (vector-ref rank x-root) (vector-ref rank y-root))
                            (vector-set! parent x-root y-root)
                            (begin
                              (vector-set! parent y-root x-root)
                              (when (= (vector-ref rank x-root) (vector-ref rank y-root))
                                (vector-set! rank x-root (+ (vector-ref rank x-root) 1)))))))]
         [max-row 0]
         [max-col 0])
    (for ([stone stones])
      (set! max-row (max max-row (car stone)))
      (set! max-col (max max-col (cdr stone))))
    (set! max-col (+ max-row 1))
    (for ([stone stones])
      (let ([x (car stone)]
            [y (+ (cdr stone) max-row 1)])
        (union x y)))
    (let ([roots (mutable-set)])
      (for ([stone stones])
        (let ([x (car stone)])
          (set-add! roots (find x))))
      (- n (set-count roots)))))