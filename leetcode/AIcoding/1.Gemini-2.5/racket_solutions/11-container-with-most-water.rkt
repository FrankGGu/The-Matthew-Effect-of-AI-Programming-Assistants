(define (max-area height)
  (let* ([n (length height)]
         [left 0]
         [right (- n 1)]
         [max-area-val 0])
    (let loop ([l left] [r right] [current-max max-area-val])
      (if (< l r)
          (let* ([h-l (list-ref height l)]
                 [h-r (list-ref height r)]
                 [current-h (min h-l h-r)]
                 [width (- r l)]
                 [area (* current-h width)])
            (if (< h-l h-r)
                (loop (+ l 1) r (max current-max area))
                (loop l (- r 1) (max current-max area))))
          current-max))))