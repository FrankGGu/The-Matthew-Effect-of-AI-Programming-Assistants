(define (trap height)
  (let* ([n (vector-length height)]
         [left 0]
         [right (- n 1)]
         [max-left 0]
         [max-right 0]
         [water 0])
    (cond
      [(< n 3) 0]
      [else
       (let loop ([l left]
                  [r right]
                  [ml max-left]
                  [mr max-right]
                  [w water])
         (if (< l r)
             (let ([h-l (vector-ref height l)]
                   [h-r (vector-ref height r)])
               (if (< h-l h-r)
                   (if (>= h-l ml)
                       (loop (+ l 1) r h-l mr w)
                       (loop (+ l 1) r ml mr (+ w (- ml h-l))))
                   (if (>= h-r mr)
                       (loop l (- r 1) ml h-r w)
                       (loop l (- r 1) ml mr (+ w (- mr h-r))))))
             w))])))