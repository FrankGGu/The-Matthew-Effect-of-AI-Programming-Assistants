#lang racket

(define (find-min-height-trees n edges)
  (cond
    ((= n 1) (list 0))
    (else
     (define adj (make-vector n (list)))
     (define degrees (make-vector n 0))

     (for-each
      (lambda (edge)
        (define u (car edge))
        (define v (cadr edge))
        (vector-set! adj u (cons v (vector-ref adj u)))
        (vector-set! adj v (cons u (vector-ref adj v)))
        (vector-set! degrees u (+ (vector-ref degrees u) 1))
        (vector-set! degrees v (+ (vector-ref degrees v) 1)))
      edges)

     (define current-leaves
       (filter (lambda (i) (= (vector-ref degrees i) 1)) (range n)))

     (let loop ((current-leaves current-leaves) (remaining-nodes n))
       (if (<= remaining-nodes 2)
           current-leaves
           (let* ((num-leaves-in-layer (length current-leaves))
                  (next-remaining-nodes (- remaining-nodes num-leaves-in-layer))
                  (next-leaves-acc '()))

             (for-each
              (lambda (u)
                (for-each
                 (lambda (v)
                   (vector-set! degrees v (- (vector-ref degrees v) 1))
                   (when (= (vector-ref degrees v) 1)
                     (set! next-leaves-acc (cons v next-leaves-acc))))
                 (vector-ref adj u)))
              current-leaves)

             (loop (reverse next-leaves-acc) next-remaining-nodes)))))))