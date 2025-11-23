(define (sand-pile n)
  (define (stable? grid i j)
    (< (list-ref (list-ref grid i) j) 4))

  (define (topple! grid i j)
    (set! (list-ref (list-ref grid i) j) (- (list-ref (list-ref grid i) j) 4))
    (when (and (> i 0)) (set! (list-ref (list-ref grid (- i 1)) j) (+ (list-ref (list-ref grid (- i 1)) j) 1)))
    (when (and (< i (- n 1))) (set! (list-ref (list-ref grid (+ i 1)) j) (+ (list-ref (list-ref grid (+ i 1)) j) 1)))
    (when (and (> j 0)) (set! (list-ref (list-ref grid i) (- j 1)) (+ (list-ref (list-ref grid i) (- j 1)) 1)))
    (when (and (< j (- n 1))) (set! (list-ref (list-ref grid i) (+ j 1)) (+ (list-ref (list-ref grid i) (+ j 1)) 1))))

  (define (stabilize! grid)
    (let loop ((changed? #f))
      (if changed?
          (loop #f)
          (let loop2 ((i 0) (j 0) (changed? #f))
            (cond
              ((= i n) grid)
              ((= j n) (loop2 (+ i 1) 0 changed?))
              (else
               (if (not (stable? grid i j))
                   (begin
                     (topple! grid i j)
                     (loop2 i (+ j 1) #t))
                   (loop2 i (+ j 1) changed?))))))))

  (define grid (make-list n (make-list n 0)))
  (stabilize! grid))