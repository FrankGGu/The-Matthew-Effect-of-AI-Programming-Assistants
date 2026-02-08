#lang racket
(require data/red-black-tree)
(require racket/list)

(define (get-skyline buildings)
  (define events '())
  (for ([b buildings])
    (define x1 (list-ref b 0))
    (define x2 (list-ref b 1))
    (define h (list-ref b 2))
    (set! events (cons (list x1 (- h) h) events))
    (set! events (cons (list x2 h h) events)))

  (define sorted-events
    (sort events
          (lambda (e1 e2)
            (define x1 (list-ref e1 0))
            (define x2 (list-ref e2 0))
            (define type1 (list-ref e1 1))
            (define type2 (list-ref e2 1))
            (cond
              ((< x1 x2) #t)
              ((> x1 x2) #f)
              (else
               (< type1 type2))))))

  (define active-heights (rbt-empty integer-comparator))
  (define result '())
  (define prev-max-height 0)

  (define (add-height! h)
    (define current-count (rbt-ref active-heights h 0))
    (set! active-heights (rbt-insert active-heights h (+ current-count 1))))

  (define (remove-height! h)
    (define current-count (rbt-ref active-heights h 0))
    (when (> current-count 0)
      (if (= current-count 1)
          (set! active-heights (rbt-remove active-heights h))
          (set! active-heights (rbt-insert active-heights h (- current-count 1))))))

  (define (get-current-max-height)
    (if (rbt-empty? active-heights)
        0
        (rbt-max-key active-heights)))

  (define grouped-events
    (group-by (lambda (e) (list-ref e 0)) sorted-events))

  (for ([group grouped-events])
    (define current-x (car group))
    (define events-at-x (cdr group))

    (for ([event events-at-x])
      (define type (list-ref event 1))
      (define h (list-ref event 2))

      (if (< type 0)
          (add-height! h)
          (remove-height! h)))

    (define current-max-height (get-current-max-height))
    (when (!= current-max-height prev-max-height)
      (set! result (cons (list current-x current-max-height) result))
      (set! prev-max-height current-max-height)))

  (reverse result))