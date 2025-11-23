(define (jump nums)
  (let* ([n (length nums)]
         [jumps 0]
         [curr-reach 0]
         [max-reach 0])
    (for/fold ([i 0]
               [jumps jumps]
               [curr-reach curr-reach]
               [max-reach max-reach])
              ([i (in-range (- n 1))])
      (let* ([reach (+ i (list-ref nums i))])
        (values (add1 i)
                (if (> i curr-reach)
                    (begin
                      (set! jumps (add1 jumps))
                      (set! curr-reach max-reach)
                      jumps)
                    jumps)
                curr-reach
                (max max-reach reach))))
    jumps))