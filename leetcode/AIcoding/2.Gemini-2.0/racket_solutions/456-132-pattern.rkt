(define (132pattern nums)
  (let* ([n (length nums)]
         [stack '()]
         [s -inf.0])
    (for/fold ([i 0])
              ([j (reverse nums)])
      (cond [(< j s) #t]
            [else (begin
                    (while (and (not (null? stack)) (< s j))
                      (set! s (car stack))
                      (set! stack (cdr stack)))
                    (cond [(< s j) #t]
                          [else (set! stack (cons j stack))
                                #f]))])))