#lang racket

(define (minimum-moves grid)
  (let* ([m (length grid)]
         [n (if (zero? m) 0 (length (car grid)))]
         [robot-pos #f]
         [target-pos #f]
         [dirs '((0 . 1) (1 . 0) (0 . -1) (-1 . 0))])
    (for* ([i (in-range m)]
           [j (in-range n)])
      (let ([cell (list-ref (list-ref grid i) j)])
        (cond
          [(equal? cell 'R) (set! robot-pos (cons i j))]
          [(equal? cell 'T) (set! target-pos (cons i j))])))
    (if (not (and robot-pos target-pos)) -1
        (let ([visited (make-hash)]
              [q (make-queue)])
          (hash-set! visited (cons robot-pos 0) #t)
          (enqueue! q (cons robot-pos 0))
          (let bfs-loop ()
            (if (queue-empty? q) -1
                (let* ([current (dequeue! q)]
                       [pos (car current)]
                       [dir (cdr current)]
                       [i (car pos)]
                       [j (cdr pos)])
                  (if (equal? pos target-pos) 0
                      (let ([next-dirs (list (modulo (add1 dir) 4)
                                             (modulo (sub1 dir) 4)
                                             dir)])
                        (for ([nd (in-list next-dirs)])
                          (let* ([di (car (list-ref dirs nd))]
                                 [dj (cdr (list-ref dirs nd))]
                                 [ni (+ i di)]
                                 [nj (+ j dj)])
                            (if (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                                (let ([cell (list-ref (list-ref grid ni) nj)])
                                  (if (not (equal? cell '#'))
                                      (let ([new-state (cons (cons ni nj) nd)])
                                        (unless (hash-has-key? visited new-state)
                                          (hash-set! visited new-state #t)
                                          (enqueue! q new-state)))))))
                        (let ([steps (bfs-loop)])
                          (if (= steps -1) -1 (add1 steps)))))))))))