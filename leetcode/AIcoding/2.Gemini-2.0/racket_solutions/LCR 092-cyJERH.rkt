(define (min-flips-mono-incr s)
  (define (string->list str)
    (string->list str))

  (define (solve lst)
    (define n (length lst))
    (define (helper idx ones)
      (cond
        [(= idx n) 0]
        [(= (list-ref lst idx) #\0)
         (min (+ 1 (helper (+ idx 1) ones))
              (helper (+ idx 1) ones))]
        [(= (list-ref lst idx) #\1)
         (min (helper (+ idx 1) (+ ones 1))
              (+ 1 ones (helper (+ idx 1) ones)))]
        [else (error "Invalid character")]))

    (define (helper2 idx ones)
      (cond
        [(= idx n) 0]
        [(= (list-ref lst idx) #\0)
         (min (+ 1 (helper2 (+ idx 1) ones))
              (helper2 (+ idx 1) ones))]
        [(= (list-ref lst idx) #\1)
         (min (helper2 (+ idx 1) (+ ones 1))
              (+ ones (helper2 (+ idx 1) ones)))]
        [else (error "Invalid character")]))

    (define (helper3 idx ones)
      (cond
        [(= idx n) 0]
        [(= (list-ref lst idx) #\0)
         (min (+ 1 (helper3 (+ idx 1) ones))
              (helper3 (+ idx 1) ones))]
        [(= (list-ref lst idx) #\1)
         (let ((keep (helper3 (+ idx 1) (+ ones 1)))
               (flip (+ ones (helper3 (+ idx 1) ones))))
           (min keep flip))]
        [else (error "Invalid character")]))

    (helper3 0 0))
  (solve (string->list s)))