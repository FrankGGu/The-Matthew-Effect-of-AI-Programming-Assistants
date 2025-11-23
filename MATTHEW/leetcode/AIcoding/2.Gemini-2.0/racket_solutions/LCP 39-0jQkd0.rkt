(define (minimum-steps grid)
  (define n (vector-length grid))
  (define m (vector-length (vector-ref grid 0)))

  (define (valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c m)))

  (define (bfs start-r start-c target-r target-c)
    (define visited (make-vector n (make-vector m #f)))
    (vector-set! (vector-ref visited start-r) start-c #t)

    (define q (list (list start-r start-c 0)))

    (define (neighbors r c)
      (filter (lambda (p)
                (let ((nr (car p)) (nc (cadr p)))
                  (and (valid? nr nc)
                       (not (vector-ref (vector-ref visited nr) nc))
                       (not (= (vector-ref (vector-ref grid nr) nc) 1)))))
              (list (list (+ r 1) c)
                    (list (- r 1) c)
                    (list r (+ c 1))
                    (list r (- c 1)))))

    (let loop ((q q))
      (cond
        ((null? q) -1)
        (else
         (let ((curr (car q)) (rest (cdr q)))
           (let ((r (car curr)) (c (cadr curr)) (dist (caddr curr)))
             (if (and (= r target-r) (= c target-c))
                 dist
                 (begin
                   (for-each (lambda (neighbor)
                               (let ((nr (car neighbor)) (nc (cadr neighbor)))
                                 (vector-set! (vector-ref visited nr) nc #t)))
                             (neighbors r c))
                   (loop (append rest (map (lambda (neighbor)
                                              (list (car neighbor) (cadr neighbor) (+ dist 1)))
                                            (neighbors r c))))))))))))

  (define start-r 0)
  (define start-c 0)
  (define target-r (- n 1))
  (define target-c (- m 1))

  (bfs start-r start-c target-r target-c))