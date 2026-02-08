#lang racket

(define/contract (width-of-binary-tree root)
  (-> (or/c null? tree-node?) exact-integer?)
  (if (null? root)
      0
      (let loop ([queue (list (cons root 1))]
                 [max-width 1])
        (if (null? queue)
            max-width
            (let*-values ([(current-level) (map cdr queue)]
                          [(left) (apply min current-level)]
                          [(right) (apply max current-level)]
                          [(new-max-width) (max max-width (- right left 1))]
              (loop
               (append*
                (for/list ([node (map car queue)])
                  (let ([pos (cdr (assoc node (map cons (map car queue) current-level)))])
                    (filter
                     (lambda (x) (not (null? (car x))))
                     (list
                      (cons (tree-node-left node) (* 2 pos))
                      (cons (tree-node-right node) (+ (* 2 pos) 1)))))))
               new-max-width))))))

(define (tree-node? x)
  (and (not (null? x))
       (hash? x)
       (hash-has-key? x 'val)
       (hash-has-key? x 'left)
       (hash-has-key? x 'right)))

(define (tree-node-left node)
  (hash-ref node 'left))

(define (tree-node-right node)
  (hash-ref node 'right))