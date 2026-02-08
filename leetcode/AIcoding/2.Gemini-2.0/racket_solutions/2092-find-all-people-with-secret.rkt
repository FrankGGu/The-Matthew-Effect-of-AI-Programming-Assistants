(define (find-all-people n meetings first-person)
  (let* ([graph (make-hash)]
         [people (make-vector n #f)]
         [q (list 0 first-person)])
    (vector-set! people 0 #t)
    (vector-set! people first-person #t)
    (for ([meeting meetings])
      (let ([x (list-ref meeting 0)]
            [y (list-ref meeting 1)]
            [t (list-ref meeting 2)])
        (hash-update! graph x (lambda (v) (cons (cons y t) v)) '())
        (hash-update! graph y (lambda (v) (cons (cons x t) v)) '())))
    (let loop ([queue q])
      (if (null? queue)
          (let loop2 ([i 0] [res '()])
            (if (= i n)
                res
                (if (vector-ref people i)
                    (loop2 (+ 1 i) (cons i res))
                    (loop2 (+ 1 i) res))))
          (let* ([person (car queue)]
                 [next-queue (cdr queue)])
            (let* ([neighbors (hash-ref graph person '())
                   [filtered-neighbors
                    (sort
                     (remove-duplicates
                      (map car (filter (lambda (neighbor) (not (vector-ref people (car neighbor)))) neighbors)))
                     (lambda (a b) (< (cdr (assoc a neighbors)) (cdr (assoc b neighbors)))))])
              (for ([neighbor filtered-neighbors])
                (vector-set! people neighbor #t)
                (set! next-queue (append next-queue (list neighbor)))))
            (loop next-queue)))))