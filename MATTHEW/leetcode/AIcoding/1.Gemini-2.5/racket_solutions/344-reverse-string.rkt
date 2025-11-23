(define (reverse-string s)
  (let* ([n (vector-length s)]
         [left 0]
         [right (- n 1)])
    (let loop ([l left] [r right])
      (when (< l r)
        (let ([temp (vector-ref s l)])
          (vector-set! s l (vector-ref s r))
          (vector-set! s r temp))
        (loop (+ l 1) (- r 1))))))