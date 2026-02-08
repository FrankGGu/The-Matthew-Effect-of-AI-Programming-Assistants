#lang racket

(require math/matrix)

(define (shortest-bridge grid)
  (define n (matrix-num-rows grid))
  (define m (matrix-num-cols grid))
  (define directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))

  (define (find-first-island)
    (for*/first ([i (in-range n)]
                 [j (in-range m)]
                 #:when (= (matrix-ref grid i j) 1))
      (cons i j)))

  (define (mark-island i j)
    (let loop ([queue (list (cons i j))]
               [island '()])
      (if (null? queue)
          island
          (let* ((curr (car queue))
                 (x (car curr))
                 (y (cdr curr))
                 (rest-queue (cdr queue))
                 (new-island (cons curr island)))
            (matrix-set! grid x y 2)
            (let ((new-queue 
                   (foldl (lambda (dir acc)
                            (let ((nx (+ x (car dir)))
                                  (ny (+ y (cdr dir))))
                              (if (and (>= nx 0) (< nx n) (>= ny 0) (< ny m) 
                                  (= (matrix-ref grid nx ny) 1))
                                  (cons (cons nx ny) acc)
                                  acc))
                          rest-queue
                          directions)))
              (loop new-queue new-island))))))

  (define first-point (find-first-island))
  (define island (mark-island (car first-point) (cdr first-point)))

  (define (bfs)
    (let loop ([queue (map (lambda (p) (cons (car p) (cdr p) 0)) island)]
               [visited (make-hash)])
      (if (null? queue)
          -1
          (let* ((curr (car queue))
                 (x (car curr))
                 (y (cadr curr))
                 (steps (cddr curr))
            (for/or ([dir directions])
              (let ((nx (+ x (car dir)))
                    (ny (+ y (cdr dir))))
                (cond
                  [(or (< nx 0) (>= nx n) (< ny 0) (>= ny m)) #f]
                  [(hash-ref visited (cons nx ny) #f) #f]
                  [(= (matrix-ref grid nx ny) 1) steps]
                  [else 
                   (hash-set! visited (cons nx ny) #t)
                   (loop (append (cdr queue) (list (cons nx ny (+ steps 1)))) visited)])))))))

  (bfs))