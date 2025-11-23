(define/contract (longest-valid-parentheses s)
  (-> string? exact-integer?)
  (let ([n (string-length s)]
        [stack '(-1)]
        [max-len 0])
    (for ([i (in-range n)])
      (let ([c (string-ref s i)])
        (if (char=? c #\( )
            (set! stack (cons i stack))
            (begin
              (set! stack (cdr stack))
              (if (null? stack)
                  (set! stack (cons i stack))
                  (set! max-len (max max-len (- i (car stack))))))))
    max-len))