#lang racket

(define (frog-position n edges t target)
  (define adj (make-vector (add1 n) '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v))))

  (define visited (make-vector (add1 n) #f))
  (define prob 1.0)
  (define found #f)

  (define (dfs node time current-prob)
    (when (and (not found) (<= time t))
      (vector-set! visited node #t)
      (cond
        [(= node target)
         (if (or (= time t) (and (< time t) (null? (filter (lambda (x) (not (vector-ref visited x))) (vector-ref adj node)))))
             (begin
               (set! prob current-prob)
               (set! found #t))
             (void))]
        [else
         (let* ([children (filter (lambda (x) (not (vector-ref visited x))) (vector-ref adj node))]
                [m (length children)])
           (for ([child children])
             (dfs child (add1 time) (/ current-prob m))))))

  (dfs 1 0 1.0)
  (if found prob 0.0))