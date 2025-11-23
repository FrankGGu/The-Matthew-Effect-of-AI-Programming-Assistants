(define (cut-off-trees forest)
  (define (bfs start goal)
    (define (neighbors pos)
      (filter (lambda (p)
                (and (>= (car p) 0)
                     (>= (cadr p) 0)
                     (< (car p) (length forest))
                     (< (cadr p) (length (vector-ref forest (car p))))))
              (list (cons (+ (car pos) 1) (cadr pos))
                    (cons (- (car pos) 1) (cadr pos))
                    (cons (car pos) (+ (cadr pos) 1))
                    (cons (car pos) (- (cadr pos) 1)))))

    (define (dist from to)
      (let loop ((queue (list from))
                 (visited (make-vector (length forest) (make-vector (length (vector-ref forest 0)) #f)))
                 (steps 0))
        (if (null? queue)
            -1
            (let* ((current (car queue))
                   (rest (cdr queue))
                   (x (car current))
                   (y (cadr current)))
              (if (equal? current goal)
                  steps
                  (begin
                    (vector-set! (vector-ref visited x) y #t)
                    (loop (append rest (filter (lambda (n)
                                                  (and (not (vector-ref (vector-ref visited (car n)) (cadr n)))
                                                       (not (equal? (vector-ref forest (car n) (cadr n)) 0))))
                                                (neighbors current)))
                          visited
                          (if (equal? current goal) steps (+ steps 1)))))))))

    (define (cut-tree start tree)
      (dist start (cons (car tree) (cadr tree))))

    (define trees (filter (lambda (x) (> (vector-ref forest (car x) (cadr x)) 1))
                          (for/list ((i (in-range (length forest)))
                                      (j (in-range (length (vector-ref forest i)))))
                            (if (not (= (vector-ref forest i j) 0))
                                (cons i j)))))

    (define total-steps
      (foldl (lambda (tree acc)
                (let* ((last (if (null? acc) '(0 0) (car acc)))
                       (steps (cut-tree last tree)))
                  (if (< steps 0) -1 (cons tree (cons (+ (second acc) steps) acc)))))
              '() trees))

    (if (< (car total-steps) 0) -1 (second total-steps)))

(define (cut-off-trees-for-golf-event forest)
  (cut-off-trees forest))