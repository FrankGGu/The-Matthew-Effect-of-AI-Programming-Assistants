#lang racket

(define (two-sum nums target)
  (let ([num-map (make-hash)])
    (for/first ([num (in-list nums)]
                [idx (in-naturals)])
      (let ([complement (- target num)])
        (if (hash-has-key? num-map complement)
            (list (hash-ref num-map complement) idx)
            (begin (hash-set! num-map num idx)
                   #f))))))