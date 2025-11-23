#lang racket

(define (k-highest-ranked-items grid price-range k)
  (define (valid? x y)
    (and (<= 0 x (- (length grid) 1))
         (<= 0 y (- (length (list-ref grid 0)) 1))))

  (define items
    (for*/list ([i (in-range (length grid))]
                [j (in-range (length (list-ref grid 0)))])
      (define price (list-ref (list-ref grid i) j))
      (when (and (>= price (car price-range))
                 (<= price (cadr price-range)))
        (cons (list i j) price))))

  (define sorted-items
    (sort items (lambda (a b)
                  (or (< (cdr a) (cdr b))
                      (and (= (cdr a) (cdr b))
                           (< (car a) (car b)))
                      (and (= (cdr a) (cdr b))
                           (= (car a) (car b))
                           (< (caar a) (caar b)))))))

  (take (map (lambda (x) (car x)) sorted-items) k))