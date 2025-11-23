#lang racket

(define (find-all-recipes recipes ingredients supplies)
  (define recipe-map (for/fold ([map (hash)]) ([i (in-indexed recipes)])
    (hash-set map (second i) (list-ref ingredients (first i)))))

  (define (can-make recipe)
    (define reqs (hash-ref recipe-map recipe))
    (and (not (null? reqs))
         (for/all ([req reqs])
           (or (member req supplies)
               (can-make req)))))

  (filter can-make (hash-keys recipe-map)))

(define (main)
  (define recipes '("bread" "sandwich" "burger"))
  (define ingredients '(("flour" "water") ("bread") ("sandwich")))
  (define supplies '("flour" "water"))
  (find-all-recipes recipes ingredients supplies))

(main)