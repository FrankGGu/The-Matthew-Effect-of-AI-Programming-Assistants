#lang racket

(require data/rbt)

(struct smallest-infinite-set (
    [next-val #:mutable]
    [added-set #:mutable]
    )
  #:transparent)

(define (smallest-infinite-set-init)
  (smallest-infinite-set 1 rbt-set-empty))

(define (smallest-infinite-set-pop-smallest sis)
  (let ([current-added-set (smallest-infinite-set-added-set sis)])
    (if (rbt-set-empty? current-added-set)
        (let ([val (smallest-infinite-set-next-val sis)])
          (set-smallest-infinite-set-next-val! sis (+ val 1))
          val)
        (let* ([min-val (rbt-set-min current-added-set)]
               [new-added-set (rbt-set-remove current-added-set min-val)])
          (set-smallest-infinite-set-added-set! sis new-added-set)
          min-val))))

(define (smallest-infinite-set-add-back sis num)
  (let ([current-next-val (smallest-infinite-set-next-val sis)])
    (when (< num current-next-val)
      (set-smallest-infinite-set-added-set! sis
                                            (rbt-set-add (smallest-infinite-set-added-set sis) num)))))

(define (SmallestInfiniteSet)
  (smallest-infinite-set-init))

(define (SmallestInfiniteSet-popSmallest obj)
  (smallest-infinite-set-pop-smallest obj))

(define (SmallestInfiniteSet-addBack obj num)
  (smallest-infinite-set-add-back obj num))