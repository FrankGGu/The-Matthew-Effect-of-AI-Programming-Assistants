#lang racket

(define (spiral-order head)
  (define (create-matrix m n)
    (build-list m (lambda (_) (build-list n 0))))

  (define (get-length node)
    (if (not node) 0 (+ 1 (get-length (cdr node)))))

  (define (list->matrix lst m n)
    (define (iter lst row col)
      (cond [(null? lst) '()]
            [else
             (let ([row-list (take lst n)])
               (cons row-list (iter (drop lst n) (add1 row) 0)))]))
    (iter lst 0 0))

  (define (spiral matrix m n)
    (define (loop top bottom left right res)
      (cond [(> top bottom) res]
            [(> left right) res]
            [else
             (for ([i (in-range left (add1 right))])
               (set! res (append res (list (list-ref (list-ref matrix top) i)))))
             (set! top (add1 top))
             (when (<= top bottom)
               (for ([i (in-range top (add1 bottom))])
                 (set! res (append res (list (list-ref (list-ref matrix i) right)))))
               (set! right (sub1 right))
               (when (and (<= left right) (<= top bottom))
                 (for ([i (in-range right (sub1 left) -1)])
                   (set! res (append res (list (list-ref (list-ref matrix bottom) i)))))
                 (set! bottom (sub1 bottom))
                 (when (and (<= left right) (<= top bottom))
                   (for ([i (in-range bottom (sub1 top) -1)])
                     (set! res (append res (list (list-ref (list-ref matrix i) left)))))
                   (set! left (add1 left))))
             (loop top bottom left right res)]))
    (loop 0 (sub1 m) 0 (sub1 n) '()))

  (define m (get-length head))
  (define n (if (> m 0) (get-length (car (list->matrix (list-head head 1) 1 1))) 0))
  (define lst (let loop ([node head] [res '()])
                (if (not node) res
                    (loop (cdr node) (append res (list (car node)))))))
  (if (or (= m 0) (= n 0)) '()
      (spiral (list->matrix lst m n) m n)))