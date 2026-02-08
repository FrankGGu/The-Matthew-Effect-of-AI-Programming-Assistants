(define (make-strings-equal s t x y)
  (let ([s1 (string->list s)]
        [t1 (string->list t)])
    (if (equal? (length s1) (length t1))
        (let loop ([i 0])
          (cond
            [(= i (length s1)) #t]
            [(and (equal? (list-ref s1 i) (list-ref t1 i)) #t) (loop (+ i 1))]
            [(and (equal? (list-ref s1 i) #\0) (equal? (list-ref t1 i) #\1) (or (= x 1) (= y 1))) (loop (+ i 1))]
            [(and (equal? (list-ref s1 i) #\1) (equal? (list-ref t1 i) #\0) (or (= x 1) (= y 1))) (loop (+ i 1))]
            [else #f]))
        #f)))