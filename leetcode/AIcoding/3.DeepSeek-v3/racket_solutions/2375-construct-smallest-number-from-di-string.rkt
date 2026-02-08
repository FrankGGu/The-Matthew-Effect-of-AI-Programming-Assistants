(define (smallest-number pattern)
  (let* ([n (string-length pattern)]
         [res (make-string (add1 n))]
         [stack '()]
         [num 1])
    (for ([i (in-range (add1 n))])
      (set! stack (cons i stack))
      (when (or (= i n) (char=? (string-ref pattern i) #\I))
        (let loop ()
          (unless (null? stack)
            (let ([pos (car stack)])
              (set! stack (cdr stack))
              (string-set! res pos (integer->char (+ (char->integer #\0) num)))
              (set! num (add1 num))
            (loop)))))
    res))