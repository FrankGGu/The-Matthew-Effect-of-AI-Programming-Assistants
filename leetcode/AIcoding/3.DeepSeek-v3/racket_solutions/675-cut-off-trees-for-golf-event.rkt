#lang racket

(require math/matrix)

(define (cut-off-trees forest)
  (define m (length forest))
  (define n (if (zero? m) 0 (length (car forest))))
  (define trees
    (for*/list ([i (in-range m)]
                [j (in-range n)]
                [h (in-value (list-ref (list-ref forest i) j))]
                #:when (> h 1))
      (list h i j)))
  (define sorted-trees (sort trees (lambda (a b) (< (car a) (car b)))))
  (define (bfs start end)
    (define (valid? x y) (and (>= x 0) (< x m) (>= y 0) (< y n) (not (zero? (list-ref (list-ref forest x) y)))))
    (define q (make-queue))
    (define visited (make-hash))
    (enqueue! q (list (cadr start) (caddr start) 0))
    (hash-set! visited (list (cadr start) (caddr start)) #t)
    (let loop ()
      (if (queue-empty? q)
          -1
          (let* ([current (dequeue! q)]
                  [x (car current)]
                  [y (cadr current)]
                  [steps (caddr current)])
            (if (and (= x (cadr end)) (= y (caddr end)))
                steps
                (begin
                  (for ([dir (list (list 1 0) (list -1 0) (list 0 1) (list 0 -1))])
                    (let ([nx (+ x (car dir))]
                          [ny (+ y (cadr dir))])
                      (when (and (valid? nx ny) (not (hash-ref visited (list nx ny) #f)))
                        (hash-set! visited (list nx ny)) #t)
                        (enqueue! q (list nx ny (+ steps 1))))))
                  (loop)))))))
  (define (helper prev res)
    (if (null? sorted-trees)
        res
        (let* ([next (car sorted-trees)]
               [dist (bfs prev next)])
          (if (= dist -1)
              -1
              (helper next (cdr sorted-trees) (+ res dist))))))
  (if (null? sorted-trees)
      0
      (helper (list 0 0 0) sorted-trees 0)))

(define (make-queue) (mcons null null))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (mcons x null)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr q) (mcons x null)) (set-mcdr! q (mcdr (mcdr q))))))
(define (dequeue! q)
  (let ([front (mcar (mcar q))])
    (set-mcar! q (mcdr (mcar q)))
    (when (null? (mcar q)) (set-mcdr! q null))
    front))
(define (queue-empty? q) (null? (mcar q)))