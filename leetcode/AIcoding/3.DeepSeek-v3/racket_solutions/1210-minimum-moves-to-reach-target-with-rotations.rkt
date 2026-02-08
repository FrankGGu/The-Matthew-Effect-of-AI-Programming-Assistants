#lang racket

(define (minimum-moves grid)
  (define n (vector-length grid))
  (define visited (make-hash))
  (define q (make-queue))
  (enqueue! q (list 0 0 0 1 'horizontal))
  (hash-set! visited (list 0 0 0 1) #t)

  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y n) (not (vector-ref (vector-ref grid x) y))))

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ([current (dequeue! q)]
                [x1 (first current)]
                [y1 (second current)]
                [x2 (third current)]
                [y2 (fourth current)]
                [orientation (fifth current)]
                [steps (sixth current)])
          (if (and (= x1 (sub1 n)) (= y1 (sub1 n)) (= x2 (sub1 n)) (= y2 (sub1 n)))
              steps
              (begin
                (for ([move (in-list (possible-moves x1 y1 x2 y2 orientation))])
                  (let ([new-x1 (first move)]
                        [new-y1 (second move)]
                        [new-x2 (third move)]
                        [new-y2 (fourth move)]
                        [new-orientation (fifth move)])
                    (when (and (valid? new-x1 new-y1) (valid? new-x2 new-y2) (not (hash-has-key? visited (list new-x1 new-y1 new-x2 new-y2))))
                      (hash-set! visited (list new-x1 new-y1 new-x2 new-y2) #t)
                      (enqueue! q (append move (list (add1 steps))))))))
                (loop))))))

(define (possible-moves x1 y1 x2 y2 orientation)
  (define moves '())
  (if (eq? orientation 'horizontal)
      (begin
        (when (valid? x1 (add1 y1)) ; right
          (set! moves (cons (list x1 (add1 y1) x2 (add1 y2) 'horizontal) moves))
        (when (valid? (add1 x1) y1)) ; down
          (set! moves (cons (list (add1 x1) y1 (add1 x2) y2 'horizontal) moves)))
        (when (and (valid? (add1 x1) y1) (valid? (add1 x1) (add1 y1))) ; rotate clockwise
          (set! moves (cons (list x1 y1 (add1 x1) (add1 y1) 'vertical) moves)))
        (when (and (valid? (add1 x1) y1) (valid? (add1 x1) (add1 y1))) ; rotate counter-clockwise
          (set! moves (cons (list x1 y1 (add1 x1) y1 'vertical) moves))))
      (begin
        (when (valid? x1 (add1 y1)) ; right
          (set! moves (cons (list x1 (add1 y1) x2 (add1 y2) 'vertical) moves)))
        (when (valid? (add1 x1) y1)) ; down
          (set! moves (cons (list (add1 x1) y1 (add1 x2) y2 'vertical) moves)))
        (when (and (valid? x1 (add1 y1) (valid? (add1 x1) (add1 y1))) ; rotate clockwise
          (set! moves (cons (list x1 y1 x1 (add1 y1) 'horizontal) moves)))
        (when (and (valid? x1 (add1 y1) (valid? (add1 x1) (add1 y1)))) ; rotate counter-clockwise
          (set! moves (cons (list x1 y1 (add1 x1) y1 'horizontal) moves)))))
  moves)