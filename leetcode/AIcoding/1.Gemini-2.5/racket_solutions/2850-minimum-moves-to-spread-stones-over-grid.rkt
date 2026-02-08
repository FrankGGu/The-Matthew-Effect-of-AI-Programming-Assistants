#lang racket

(define (minimum-moves grid)
  (define all-sources '())
  (define all-destinations '())

  (for* ([r (in-range 3)]
         [c (in-range 3)])
    (let ([stones (list-ref (list-ref grid r) c)])
      (cond
        [(> stones 1)
         (set! all-sources (append all-sources (build-list (- stones 1) (lambda (_) (cons r c)))))]
        [(< stones 1)
         (set! all-destinations (append all-destinations (build-list (- 1 stones) (lambda (_) (cons r c)))))])))

  (define (manhattan-distance p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cdr p1) (cdr p2)))))

  (define (solve current-sources current-destinations)
    (if (empty? current-sources)
        0
        (let* ([s (car current-sources)]
               [rest-sources (cdr current-sources)])
          (define min-cost +inf.0)

          (for ([d current-destinations])
            (let* ([dist (manhattan-distance s d)]
                   [remaining-destinations (remove d current-destinations 1)]
                   [current-total-cost (+ dist (solve rest-sources remaining-destinations))])
              (when (< current-total-cost min-cost)
                (set! min-cost current-total-cost))))
          min-cost)))

  (solve all-sources all-destinations))