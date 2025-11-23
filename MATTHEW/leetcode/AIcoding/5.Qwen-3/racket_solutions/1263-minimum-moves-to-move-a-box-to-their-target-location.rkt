#lang racket

(define (min-moves grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (find-start-target)
    (for*/list ([i (in-range rows)]
                [j (in-range cols)])
      (cond [(char=? (string-ref (list-ref grid i) j) #\B) (list i j)]
            [(char=? (string-ref (list-ref grid i) j) #\T) (list i j)])))

  (define-values (player target)
    (let ([pts (find-start-target)])
      (values (list-ref pts 0) (list-ref pts 1))))

  (define (is-valid? x y)
    (and (>= x 0) (< x rows) (>= y 0) (< y cols) (not (char=? (string-ref (list-ref grid x) y) #\#))))

  (define (bfs box-x box-y)
    (define visited (make-hash))
    (define queue (queue (cons player box-x box-y 0)))
    (define directions '((0 1) (1 0) (0 -1) (-1 0)))

    (define (enqueue x y moves)
      (when (not (hash-has-key? visited (cons x y)))
        (hash-set! visited (cons x y) #t)
        (queue-add! queue (cons (cons x y) moves))))

    (define (move-player px py dx dy)
      (let ([nx (+ px dx)] [ny (+ py dy)])
        (when (is-valid? nx ny)
          (if (and (= nx box-x) (= ny box-y))
              (begin
                (when (is-valid? (+ nx (car directions)) (+ ny (cadr directions)))
                  (enqueue nx ny (+ moves 1)))
                #f)
              (enqueue nx ny (+ moves 1)))))

    (define (process)
      (when (not (queue-empty? queue))
        (let* ([current (queue-remove! queue)]
               [pos (car current)]
               [moves (cdr current)]
               [px (car pos)]
               [py (cdr pos)]
               [bx box-x]
               [by box-y])
          (for-each
           (lambda (d)
             (let ([dx (car d)] [dy (cadr d)])
               (when (and (is-valid? (+ px dx) (+ py dy))
                          (or (not (and (= (+ px dx) bx) (= (+ py dy) by)))
                              (is-valid? (+ px (* 2 dx)) (+ py (* 2 dy)))))
                 (if (and (= (+ px dx) bx) (= (+ py dy) by))
                     (enqueue bx by (+ moves 1))
                     (enqueue (+ px dx) (+ py dy) (+ moves 1)))))
           directions)
          (process))))

    (enqueue player 0)
    (process)
    (hash-ref visited (cons target 0) #f))

  (bfs (car target) (cadr target)))