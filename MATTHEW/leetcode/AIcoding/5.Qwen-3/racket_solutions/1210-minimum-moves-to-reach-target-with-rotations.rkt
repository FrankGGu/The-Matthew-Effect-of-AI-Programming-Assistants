#lang racket

(define (min-moves grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define target (cons (- rows 1) (- cols 1)))

  (define (is-valid? x y)
    (and (>= x 0) (< x rows) (>= y 0) (< y cols)))

  (define (get-adjacent x y)
    (for/fold ([adj '()]) ([d directions])
      (let* ([dx (car d)]
             [dy (cadr d)]
             [nx (+ x dx)]
             [ny (+ y dy)])
        (if (is-valid? nx ny)
            (cons (cons nx ny) adj)
            adj))))

  (define (bfs)
    (define visited (make-hash))
    (define queue (list (cons (cons 0 0) '())))
    (define (enqueue pos dir)
      (hash-set! visited pos #t)
      (set! queue (append queue (list (cons pos dir)))))

    (define (process)
      (when (not (null? queue))
        (let* ([current (car queue)]
               [pos (car current)]
               [dir (cadr current)]
               [x (car pos)]
               [y (cadr pos)])
          (set! queue (cdr queue))
          (cond [(equal? pos target) (length dir)]
                [else
                 (for-each
                  (lambda (next-pos)
                    (let ([nx (car next-pos)]
                          [ny (cadr next-pos)])
                      (when (and (is-valid? nx ny) (not (hash-has-key? visited next-pos)))
                        (enqueue next-pos (append dir (list (cons nx ny)))))))
                  (get-adjacent x y))
                 (when (and (<= 1 x) (<= 1 y) (is-valid? (- x 1) (- y 1)) (not (hash-has-key? visited (cons (- x 1) (- y 1)))))
                   (enqueue (cons (- x 1) (- y 1)) (append dir (list (cons x y)))))])
          (process))))

    (enqueue (cons 0 0) '())
    (process))

  (bfs))