#lang racket

(require racket/set)

(define (arithmetic-triplets nums diff)
  (let ([num-set (list->set nums)])
    (for/sum ([n nums])
      (if (and (set-member? num-set (+ n diff))
               (set-member? num-set (+ n (* 2 diff))))
          1
          0))))