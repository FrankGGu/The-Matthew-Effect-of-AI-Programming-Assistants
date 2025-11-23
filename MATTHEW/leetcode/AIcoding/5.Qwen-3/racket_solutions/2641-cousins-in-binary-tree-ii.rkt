#lang racket

(define (is-cousins root x y)
  (define (bfs)
    (let loop ([queue (list (cons root #f))])
      (cond [(null? queue) #f]
            [else
             (let* ([size (length queue)]
                    [level (make-hash)])
               (for ([i (in-range size)])
                 (let* ([node (caar queue)]
                        [parent (cdar queue)])
                   (hash-set! level (if (equal? node x) x (if (equal? node y) y #f)) parent)
                   (when (and (not (null? (node-left node))) (not (null? (node-right node))))
                     (when (and (equal? (node-left node) x) (equal? (node-right node) y))
                       (return #f)))
                   (when (and (not (null? (node-left node))) (equal? (node-left node) x))
                     (hash-set! level x parent))
                   (when (and (not (null? (node-right node))) (equal? (node-right node) y))
                     (hash-set! level y parent))
                   (set! queue (append queue (filter values (list (cons (node-left node) node) (cons (node-right node) node))))))
               (if (and (hash-has-key? level x) (hash-has-key? level y) (not (equal? (hash-ref level x) (hash-ref level y))))
                   #t
                   (loop (cdr queue))))])))
  (bfs))