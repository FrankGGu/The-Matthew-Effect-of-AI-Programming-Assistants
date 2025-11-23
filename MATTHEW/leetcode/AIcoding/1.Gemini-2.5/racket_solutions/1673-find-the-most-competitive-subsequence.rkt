(define (most-competitive nums k)
  (let* ([n (length nums)]
         [res '()]) ; res acts as a stack, with car being the top
    (for ([i (in-range n)])
      (let ([current-num (list-ref nums i)])
        (let loop ()
          (when (and (not (null? res))
                     (< current-num (car res))
                     (>= (+ (length res) (- n i) -1) k))
            (set! res (cdr res))
            (loop)))
        (when (< (length res) k)
          (set! res (cons current-num res)))))
    (reverse res)))