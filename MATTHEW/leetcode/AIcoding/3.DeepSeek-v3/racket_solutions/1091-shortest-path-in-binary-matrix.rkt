(define/contract (shortest-path-binary-matrix grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length grid)]
         [dirs '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1))])
    (if (or (zero? n) (= 1 (caar grid)))
        -1
        (let loop ([queue (list (list 0 0 1))]
                   [visited (make-hash '((0 . 0)))])
          (if (null? queue)
              -1
              (let* ([current (car queue)]
                     [x (car current)]
                     [y (cadr current)]
                     [steps (caddr current)])
                (if (and (= x (sub1 n)) (= y (sub1 n)))
                    steps
                    (let ([new-queue (cdr queue)])
                      (for ([dir dirs]
                            #:when (let ([nx (+ x (car dir))]
                                     [ny (+ y (cadr dir))])
                                     (and (>= nx 0) (< nx n)
                                          (>= ny 0) (< ny n)
                                          (zero? (list-ref (list-ref grid nx) ny))
                                          (not (hash-has-key? visited (cons nx ny)))))
                        (set! new-queue (append new-queue (list (list nx ny (add1 steps)))))
                        (hash-set! visited (cons nx ny) #t))
                      (loop new-queue visited))))))))