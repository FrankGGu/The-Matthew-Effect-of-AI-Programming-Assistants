#lang racket

(define (zigzag-level-order root)
  (define (reverse-levels levels)
    (for/list ([level (in-list levels)]
               [i (in-naturals)])
      (if (odd? i) (reverse level) level)))
  (define (bfs node)
    (let loop ([queue (if (null? node) '() (list node))]
               [levels '()])
      (if (null? queue)
          (reverse levels)
          (let* ([vals (map (λ (n) (vector-ref n 0)) queue)]
                 [next-queue (append* 
                              (map (λ (n) 
                                     (filter values 
                                             (list (vector-ref n 1) 
                                                   (vector-ref n 2))))
                                   ) queue))])
            (loop next-queue (cons vals levels))))))
  (reverse-levels (bfs root)))