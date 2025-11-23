#lang racket

(define (cut-off-trees forest)
  (define (bfs start target)
    (define (helper q visited steps)
      (cond [(null? q) -1]
            [else
             (define current (car q))
             (define x (car current))
             (define y (cadr current))
             (if (and (= x (car target)) (= y (cadr target)))
                 steps
                 (let ([next (filter (lambda (p) (and (>= (car p) 0) (< (car p) (length forest)) (>= (cadr p) 0) (< (cadr p) (length (list-ref forest 0))) (not (member p visited)) (not (= (list-ref forest (car p)) (cadr p)))) (list (list (sub1 x) y) (list (add1 x) y) (list x (sub1 y)) (list x (add1 y)) ))])
                   (helper (append (cdr q) next) (append visited (list current)) (add1 steps))))]))
    (helper (list start) '() 0))

  (define (sort-trees)
    (for/fold ([res '()]) ([i (in-range (length forest))])
      (for/fold ([res res]) ([j (in-range (length (list-ref forest 0)))])
        (if (= (list-ref (list-ref forest i) j) 0)
            res
            (cons (list i j) res)))))

  (define trees (sort-trees))
  (define (path-lengths)
    (define (loop current pos steps)
      (if (null? pos)
          steps
          (let* ([next (bfs current (car pos))]
                 [new-steps (if (= next -1) -1 (+ steps next))])
            (if (= new-steps -1)
                -1
                (loop (car pos) (cdr pos) new-steps)))))
    (loop (list 0 0) trees 0))

  (path-lengths))