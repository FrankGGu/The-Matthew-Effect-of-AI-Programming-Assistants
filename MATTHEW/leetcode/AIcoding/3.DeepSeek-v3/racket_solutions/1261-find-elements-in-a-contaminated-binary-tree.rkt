#lang racket

(define find-elements%
  (class object%
    (super-new)
    (init-field root)
    (define root-set (mutable-set))

    (define (traverse node val)
      (when node
        (set-add! root-set val)
        (traverse (send node get-left) (+ (* 2 val) 1))
        (traverse (send node get-right) (+ (* 2 val) 2))))

    (traverse root 0)

    (define/public (find target)
      (set-member? root-set target))
    )