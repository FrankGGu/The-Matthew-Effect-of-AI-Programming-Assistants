(define (count-ungarded-cells grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [guards (for/list ([i (in-range m)]
                             [j (in-range n)]
                             #:when (equal? (list-ref (list-ref grid i) j) 'g'))
                   (list i j))]
         [walls (for/list ([i (in-range m)]
                            [j (in-range n)]
                            #:when (equal? (list-ref (list-ref grid i) j) 'w'))
                  (list i j))]
         [guarded (make-hash)]
         [mark-guarded
          (lambda (i j)
            (hash-set! guarded (list i j) #t))]
         [check-and-mark
          (lambda (i j)
            (and (>= i 0)
                 (< i m)
                 (>= j 0)
                 (< j n)
                 (not (member (list i j) walls))
                 (not (hash-has-key? guarded (list i j)))
                 (mark-guarded i j))))]
    (for ([guard guards])
      (let* ([gi (car guard)]
             [gj (cadr guard)])
        (mark-guarded gi gj)
        (let loop-right ([j (+ gj 1)])
          (when (and (>= j 0) (< j n) (not (member (list gi j) walls)))
            (mark-guarded gi j)
            (loop-right (+ j 1))))
        (let loop-left ([j (- gj 1)])
          (when (and (>= j 0) (< j n) (not (member (list gi j) walls)))
            (mark-guarded gi j)
            (loop-left (- j 1))))
        (let loop-down ([i (+ gi 1)])
          (when (and (>= i 0) (< i m) (not (member (list i gj) walls)))
            (mark-guarded i gj)
            (loop-down (+ i 1))))
        (let loop-up ([i (- gi 1)])
          (when (and (>= i 0) (< i m) (not (member (list i gj) walls)))
            (mark-guarded i gj)
            (loop-up (- i 1))))))
    (- (* m n) (hash-count guarded) (length walls))))