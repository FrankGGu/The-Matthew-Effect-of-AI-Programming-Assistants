(define (largestRectangleArea heights)
  (define n (length heights))
  (define stack '())
  (define max-area 0)

  (define (calculate-area height width)
    (* height width))

  (for/fold ([i 0]) ([h heights])
    (begin
      (set! stack (cons i stack))
      (set! i (+ i 1)))
    (let loop ([index 0])
      (if (< index (length stack))
          (let ([top (car stack)])
            (if (or (null? (cdr stack)) 
                    (< (list-ref heights top) h))
                (begin
                  (set! stack (cdr stack))
                  (let ([width (if (null? stack)
                                   i
                                   (- i (car stack) 1))])
                    (set! max-area (max max-area (calculate-area (list-ref heights top) width))))
                  (loop index))
                (loop (+ index 1)))))))
  (for ([i (in-range n)])
    (let ([h (list-ref heights i)])
      (if (or (null? stack) (< (list-ref heights (car stack)) h))
          (set! stack (cons i stack))
          (begin
            (while (and (not (null? stack)) 
                        (>= (list-ref heights (car stack)) h))
              (let ([top (car stack)])
                (set! stack (cdr stack))
                (let ([width (if (null? stack) 
                                 i 
                                 (- i (car stack) 1))])
                  (set! max-area (max max-area (calculate-area (list-ref heights top) width)))))))))))
  max-area)

(largestRectangleArea '(2 1 5 6 2 3))