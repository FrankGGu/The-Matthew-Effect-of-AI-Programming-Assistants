#lang racket

(define (escape-maze maze)
  (define rows (length maze))
  (define cols (if (> rows 0) (length (car maze)) 0))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define visited (make-hash))
  (define (in-bounds x y)
    (and (>= x 0) (< x rows) (>= y 0) (< y cols)))
  (define (bfs start-x start-y)
    (define queue (list (cons (cons start-x start-y) 0)))
    (hash-set! visited (cons start-x start-y) #t)
    (let loop ()
      (when (not (null? queue))
        (define current (car queue))
        (define pos (car current))
        (define steps (cdr current))
        (define x (car pos))
        (define y (cdr pos))
        (cond
          [(or (= (list-ref maze x) (list-ref (list-ref maze x) y)) (equal? (list-ref (list-ref maze x) y) "E")) (add1 steps)]
          [else
           (for-each
            (lambda (d)
              (define nx (+ x (car d)))
              (define ny (+ y (cadr d)))
              (when (and (in-bounds nx ny) (not (hash-has-key? visited (cons nx ny))) (not (equal? (list-ref (list-ref maze nx) ny) "X")))
                (hash-set! visited (cons nx ny) #t)
                (set! queue (append queue (list (cons (cons nx ny) (add1 steps)))))))
            directions)
           (loop)])))
  (for* ((i (in-range rows)) (j (in-range cols)))
    (when (equal? (list-ref (list-ref maze i) j) "S")
      (bfs i j))))