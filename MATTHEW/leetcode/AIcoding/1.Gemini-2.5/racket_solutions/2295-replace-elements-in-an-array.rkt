(define (replace-elements arr)
  (let* ([n (vector-length arr)]
         [max-so-far -1])
    (for ([i (range (- n 1) -1 -1)])
      (let ([current-element (vector-ref arr i)])
        (vector-set! arr i max-so-far)
        (set! max-so-far (max max-so-far current-element))))
    arr))