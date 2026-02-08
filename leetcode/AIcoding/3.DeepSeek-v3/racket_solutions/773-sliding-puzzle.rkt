#lang racket

(define (sliding-puzzle board)
  (define target '((1 2 3) (4 5 0)))
  (define moves '((1 0) (-1 0) (0 1) (0 -1)))

  (define (find-zero board)
    (for*/first ([i (in-range 2)]
                 [j (in-range 3)]
                 #:when (zero? (list-ref (list-ref board i) j)))
      (list i j)))

  (define (swap board i1 j1 i2 j2)
    (define (update-row row j val)
      (for/list ([x (in-range 3)]
                 [v (in-list row)])
        (if (= x j) val v)))
    (let* ([val1 (list-ref (list-ref board i1) j1)]
           [val2 (list-ref (list-ref board i2) j2)]
           [new-board (for/list ([i (in-range 2)]
                                 [row (in-list board)])
                        (cond [(= i i1) (update-row row j1 val2)]
                              [(= i i2) (update-row row j2 val1)]
                              [else row]))])
      new-board))

  (define (serialize board)
    (append (list-ref board 0) (list-ref board 1)))

  (let* ([start (find-zero board)]
         [q (mutable-set (cons (serialize board) start))]
         [visited (mutable-set (serialize board))]
         [steps 0])
    (let loop ()
      (cond [(set-empty? q) -1]
            [else
             (define current-level (set->list q))
             (set! q (mutable-set))
             (for ([state (in-list current-level)])
               (define serial (car state))
               (define pos (cdr state))
               (define i (car pos))
               (define j (cadr pos))
               (when (equal? serial (serialize target))
                 (return steps))
               (for ([move (in-list moves)])
                 (define ni (+ i (car move)))
                 (define nj (+ j (cadr move)))
                 (when (and (>= ni 0) (< ni 2) (>= nj 0) (< nj 3))
                   (define new-board (swap (deserialize serial) i j ni nj))
                   (define new-serial (serialize new-board))
                   (when (not (set-member? visited new-serial))
                     (set-add! visited new-serial)
                     (set-add! q (cons new-serial (list ni nj)))))))
             (set! steps (add1 steps))
             (loop)]))))

(define (deserialize lst)
  (list (take lst 3) (drop lst 3)))