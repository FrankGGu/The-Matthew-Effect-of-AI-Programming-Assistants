#lang racket

(define (count-pairs-of-connectable-servers edges signalSpeed)
  (define n (add1 (length edges)))
  (define adj (make-vector n '()))
  (for ([e edges])
    (let ([u (car e)]
          [v (cadr e)]
          [w (caddr e)])
      (vector-set! adj u (cons (list v w) (vector-ref adj u)))
      (vector-set! adj v (cons (list u w) (vector-ref adj v)))))

  (define (dfs u parent dist)
    (let loop ([neighbors (vector-ref adj u)]
               [count 0])
      (if (null? neighbors)
          count
          (let* ([v (caar neighbors)]
                 [w (cadar neighbors)]
                 [new-dist (+ dist w)])
            (if (and (not (= v parent))
                     (zero? (modulo new-dist signalSpeed)))
                (loop (cdr neighbors) (add1 (loop (cdr neighbors) count)))
                (loop (cdr neighbors) count))))))

  (define res '())
  (for ([i (in-range n)])
    (define cnt 0)
    (define total 0)
    (define counts '())
    (for ([neighbor (vector-ref adj i)])
      (let* ([v (car neighbor)]
             [w (cadr neighbor)]
             [c (if (zero? (modulo w signalSpeed))
                   (add1 (dfs v i w))
                   (dfs v i w)]))
      (set! counts (cons c counts)))
    (set! counts (reverse counts))
    (set! total (apply + counts))
    (set! cnt (for/sum ([j (in-range (length counts))])
                (* (list-ref counts j) (- total (list-ref counts j)))))
    (set! cnt (quotient cnt 2))
    (set! res (cons cnt res)))
  (reverse res))