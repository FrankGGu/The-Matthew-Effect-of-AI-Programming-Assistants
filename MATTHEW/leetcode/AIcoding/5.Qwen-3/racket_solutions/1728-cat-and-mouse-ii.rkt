#lang racket

(define (cat-mouse-ii grid k)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define memo (make-hash))

  (define (key m1 m2 t)
    (cons (cons m1 m2) t))

  (define (get-state m1 m2 t)
    (cond [(= t k) 'draw]
          [(= m1 m2) 'mouse-win]
          [(= (vector-ref (vector-ref grid m1) m2) #\C) 'cat-win]
          [else #f]))

  (define (dfs m1 m2 t)
    (let ([state (get-state m1 m2 t)])
      (if state
          state
          (let ([current-key (key m1 m2 t)])
            (if (hash-has-key? memo current-key)
                (hash-ref memo current-key)
                (let ([result 'draw])
                  (for-each
                   (lambda (dir)
                     (let* ([new-m1 (add1 m1)]
                            [new-m2 (add1 m2)]
                            [new-t (add1 t)])
                       (when (and (<= new-m1 (- rows 1)) (<= new-m2 (- cols 1)))
                         (let ([next-result (dfs new-m1 new-m2 new-t)])
                           (cond [(eqv? next-result 'mouse-win) (set! result 'mouse-win)]
                                 [(eqv? next-result 'cat-win) (set! result 'cat-win)])))))
                   '((0 1) (1 0) (0 -1) (-1 0)))
                  (hash-set! memo current-key result)
                  result)))))

  (define (solve)
    (let loop ([m1 0] [m2 0] [t 0])
      (if (or (= m1 rows) (= m2 cols))
          'draw
          (let ([state (get-state m1 m2 t)])
            (if state
                state
                (let ([result (dfs m1 m2 t)])
                  (if (eqv? result 'draw)
                      (loop (add1 m1) m2 t)
                      result)))))))

  (solve))