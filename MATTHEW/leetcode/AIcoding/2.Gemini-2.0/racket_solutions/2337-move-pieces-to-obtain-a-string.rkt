(define (move-pieces-to-obtain-a-string start target)
  (define (valid? s t)
    (equal? (filter (lambda (c) (or (equal? c #\L) (equal? c #\R))) s)
            (filter (lambda (c) (or (equal? c #\L) (equal? c #\R))) t)))

  (define (solve s t)
    (if (not (valid? s t))
        #f
        (let loop ([s-idx 0] [t-idx 0])
          (cond
            [(= s-idx (string-length s)) (= t-idx (string-length t))]
            [(= t-idx (string-length t)) #f]
            [(= s-idx (string-length s)) #f]
            [(= (string-ref s s-idx) #\_) (loop (+ s-idx 1) t-idx)]
            [(= (string-ref t t-idx) #\_) (loop s-idx (+ t-idx 1))]
            [(= (string-ref s s-idx) (string-ref t t-idx))
             (cond
               [(= (string-ref s s-idx) #\L) (if (>= s-idx t-idx) (loop (+ s-idx 1) (+ t-idx 1)) #f)]
               [(= (string-ref s s-idx) #\R) (if (<= s-idx t-idx) (loop (+ s-idx 1) (+ t-idx 1)) #f)]
               [else #f])]
            [else #f]))))

  (solve start target))