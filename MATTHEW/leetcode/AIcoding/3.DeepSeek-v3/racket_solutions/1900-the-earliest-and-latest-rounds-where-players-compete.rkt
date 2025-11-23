#lang racket

(define (earliest-and-latest n firstPlayer secondPlayer)
  (define (dfs f s l r round earliest latest)
    (cond
      [(= f s) (values round round)]
      [(> f s) (dfs s f l r round earliest latest)]
      [(and (<= f l) (>= s r)) (values (+ round 1) (+ round 1))]
      [else
       (let* ([m (quotient (+ l r) 2)]
              [new-f (if (<= f m) f (- l (- f l) 1))]
              [new-s (if (<= s m) s (- l (- s l) 1))]
              [new-l (if (<= s m) l m)]
              [new-r (if (<= s m) m r)])
         (dfs new-f new-s new-l new-r (+ round 1) earliest latest))]))

  (define-values (earliest latest) (dfs firstPlayer secondPlayer 1 n 1 +inf.0 -inf.0))
  (list earliest latest))