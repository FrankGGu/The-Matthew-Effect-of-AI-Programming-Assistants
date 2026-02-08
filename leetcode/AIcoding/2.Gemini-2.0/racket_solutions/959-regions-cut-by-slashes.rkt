(define (regions-by-slashes grid)
  (let* ([n (vector-length (vector-ref grid 0))]
         [size (+ 1 (* n 3))]
         [uf (make-union-find size)]
         (define (union-find size)
           (let ([parent (make-vector size 0)])
             (for ([i (in-range size)])
               (vector-set! parent i i))
             (λ (op a b)
               (cond [(eq? op 'find)
                      (letrec ([find (λ (x)
                                       (if (equal? x (vector-ref parent x))
                                           x
                                           (let ([root (find (vector-ref parent x))])
                                             (vector-set! parent x root)
                                             root))))]
                        (find a))]
                     [(eq? op 'union)
                      (let ([root-a (uf 'find a)]
                            [root-b (uf 'find b)])
                        (unless (equal? root-a root-b)
                          (vector-set! parent root-a root-b))))
                     [else (error "Invalid operation")]))))
         (define (index x y k)
           (+ (* (+ (* x 3) k) size) (+ y (* 3 n)))))

    (for ([i (in-range size)])
      (for ([j (in-range size)])
        (when (or (= i 0) (= j 0) (= i (- size 1)) (= j (- size 1)))
          (uf 'union 0 (+ (* i size) j)))))

    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (let ([cell (vector-ref (vector-ref grid i) j)])
          (cond
            [(equal? cell #\/)
             (uf 'union (index i j 0) (index i j 1))
             (uf 'union (index i j 2) (index i j 3))]
            [(equal? cell #\\)
             (uf 'union (index i j 0) (index i j 3))
             (uf 'union (index i j 2) (index i j 1))]
            [else
             (uf 'union (index i j 0) (index i j 1))
             (uf 'union (index i j 1) (index i j 2))
             (uf 'union (index i j 2) (index i j 3))]
            ))))

    (let ([count 0]
          [visited (make-vector (* size size) #f)])
      (for ([i (in-range (* size size))])
        (unless (vector-ref visited i)
          (let ([root (uf 'find i)])
            (unless (vector-ref visited root)
              (set! count (+ count 1))
              (vector-set! visited root #t)))))
      count)))

(define (make-union-find size)
  (let ([parent (make-vector size 0)])
    (for ([i (in-range size)])
      (vector-set! parent i i))
    (λ (op a b)
      (cond [(eq? op 'find)
             (letrec ([find (λ (x)
                              (if (equal? x (vector-ref parent x))
                                  x
                                  (let ([root (find (vector-ref parent x))])
                                    (vector-set! parent x root)
                                    root))))]
               (find a))]
            [(eq? op 'union)
             (let ([root-a (make-union-find-find parent a)]
                   [root-b (make-union-find-find parent b)])
               (unless (equal? root-a root-b)
                 (vector-set! parent root-a root-b))))
            [else (error "Invalid operation")]))))

(define (make-union-find-find parent x)
  (if (equal? x (vector-ref parent x))
      x
      (let ([root (make-union-find-find parent (vector-ref parent x))])
        (vector-set! parent x root)
        root)))