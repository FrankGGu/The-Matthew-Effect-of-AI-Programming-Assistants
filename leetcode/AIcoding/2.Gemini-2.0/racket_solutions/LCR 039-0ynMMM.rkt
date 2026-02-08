(define (largestRectangleArea heights)
  (let* ([n (length heights)]
         [stack (list)]
         [max-area 0])
    (for ([i (in-range (add1 n))])
      (let loop ()
        (cond [(and (not (empty? stack))
                    (or (= i n)
                        (<= (list-ref heights (car stack)) (list-ref heights i))))
               (let* ([top (car stack)]
                      [stack (cdr stack)]
                      [area (* (list-ref heights top)
                               (if (empty? stack)
                                   i
                                   (- i (add1 (car stack)))))]
                      [max-area (max max-area area)])
                 (set! max-area max-area)
                 (loop))]
              [else (unless (= i n)
                      (set! stack (cons i stack)))]))
    max-area))