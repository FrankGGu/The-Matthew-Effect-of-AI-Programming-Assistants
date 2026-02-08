(define skiplist
  (let* ([node (lambda (key value next) (list key value next))]
         [head (node -1 -1 '())]
         [max-level 16]
         [random-level (lambda () (let loop ([level 1])
                                      (if (and (< (random) 0.5) (< level max-level))
                                          (loop (+ level 1))
                                          level)))]
         [find (lambda (key)
                  (let loop ([current head]
                             [level (sub1 max-level)])
                    (if (negative? level)
                        current
                        (let ([next (caddr current)])
                          (if (and next (>= (car next) key))
                              (loop current (sub1 level))
                              (loop next level))))))])
    (define (add key value)
      (let* ([update (make-vector max-level)]
             [current (find key)]
             [level (random-level)])
        (for ([i (in-range level)])
          (vector-set! update i head))
        (for ([i (sub1 level)] [j (in-range level)])
          (let ([next (caddr (vector-ref update j))])
            (set-cdr! (vector-ref update j) (node key value next))))
        (set-cdr! (vector-ref update 0) (node key value (caddr current)))))

    (define (search key)
      (let ([current (find key)])
        (and (caddr current) (= (car (caddr current)) key))))

    (define (erase key)
      (let ([update (make-vector max-level)]
            [current (find key)])
        (if (and (caddr current) (= (car (caddr current)) key))
            (begin
              (for ([i (in-range max-level)])
                (when (and (vector-ref update i) (equal? (vector-ref update i) current))
                  (vector-set! update i (caddr (vector-ref update i)))))
              #t)
            #f)))

    (define (skiplist-init)
      (set! add add)
      (set! search search)
      (set! erase erase))

    (skiplist-init)
    (lambda () (list add search erase))))