#lang racket

(define (smallest-sufficient-team skill-set target)
  (define target-len (length target))
  (define skill-map (make-hash))
  (for ([i (in-range (length skill-set))])
    (for ([s (in-list (vector->list (vector-ref skill-set i)))])
      (hash-update! skill-map s (λ (lst) (cons i lst)) '())))

  (define (bitmask->vec bm)
    (for/list ([i (in-range target-len)])
      (if (bitwise-and bm (arithmetic-shift 1 i)) 1 0)))

  (define (vec->bitmask vec)
    (for/sum ([i (in-range (length vec))] [v (in-list vec)])
      (if (= v 1) (arithmetic-shift 1 i) 0)))

  (define (combine a b)
    (for/list ([i (in-range target-len)])
      (max (list-ref a i) (list-ref b i))))

  (define (solve)
    (define dp (make-hash))
    (hash-set! dp 0 '())
    (for ([s (in-hash-keys skill-map)])
      (define s-skills (bitmask->vec (vec->bitmask (map (λ (x) 1) (hash-ref skill-map s)))))
      (for ([bm (in-hash-keys dp)])
        (define new-bm (vec->bitmask (combine (bitmask->vec bm) s-skills)))
        (define new-team (append (hash-ref dp bm) (hash-ref skill-map s)))
        (when (or (not (hash-has-key? dp new-bm)) (< (length new-team) (length (hash-ref dp new-bm))))
          (hash-set! dp new-bm new-team))))
    (hash-ref dp (vec->bitmask (map (λ (x) 1) target))))

  (solve))