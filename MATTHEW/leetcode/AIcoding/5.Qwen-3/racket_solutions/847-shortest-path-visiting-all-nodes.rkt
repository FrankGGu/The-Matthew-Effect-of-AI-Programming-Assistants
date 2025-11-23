#lang racket

(define (shortest-visit-all-nodes graph)
  (define n (length graph))
  (define target (bitwise-not 0))
  (define visited (make-hash))
  (define q (queue))
  (for ([i (in-range n)])
    (queue-add! q (cons i (bitwise-ior 1 i)))
    (hash-set! visited (cons i (bitwise-ior 1 i)) #t))
  (let loop ()
    (when (queue-empty? q) (error "no solution"))
    (define state (queue-remove! q))
    (define node (car state))
    (define mask (cdr state))
    (if (= mask target)
        (let loop ([steps 0] [q (queue)])
          (if (queue-empty? q) steps
              (let ([s (queue-remove! q)])
                (if (= (cdr s) target)
                    steps
                    (loop (+ steps 1) q)))))
        (begin
          (for-each
           (lambda (neighbor)
             (define new-mask (bitwise-ior mask (bitwise-ior 1 neighbor)))
             (define key (cons neighbor new-mask))
             (when (not (hash-has-key? visited key))
               (hash-set! visited key #t)
               (queue-add! q key)))
           (list-ref graph node))
          (loop)))))