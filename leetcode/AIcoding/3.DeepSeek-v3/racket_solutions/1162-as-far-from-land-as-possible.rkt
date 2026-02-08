(define/contract (max-distance grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length grid)]
         [directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0))]
         [queue (for*/fold ([q '()])
                         ([i (in-range n)]
                          [j (in-range n)]
                          #:when (= (list-ref (list-ref grid i) j) 1))
                  (cons (cons i j) q))]
         [visited (make-hash (map (lambda (x) (cons x #t)) queue))])
    (if (or (null? queue) (= (length queue) (* n n)))
        -1
        (let loop ([queue queue]
                   [dist -1])
          (if (null? queue)
              (sub1 dist)
              (let-values ([(new-queue new-dist)
                           (for/fold ([new-q '()]
                                      [d (add1 dist)]
                                      #:result (values new-q d))
                                     ([cell (in-list queue)])
                             (let ([i (car cell)]
                                   [j (cdr cell)])
                               (for/fold ([q new-q]
                                          [dist d])
                                         ([dir (in-list directions)])
                                 (let ([ni (+ i (car dir))]
                                       [nj (+ j (cdr dir))])
                                   (if (and (>= ni 0) (< ni n)
                                         (>= nj 0) (< nj n)
                                       (let ([key (cons ni nj)])
                                         (if (not (hash-ref visited key #f))
                                             (begin
                                               (hash-set! visited key #t)
                                               (values (cons key q) dist))
                                             (values q dist)))
                                       (values q dist))))))])
                (loop new-queue new-dist)))))))