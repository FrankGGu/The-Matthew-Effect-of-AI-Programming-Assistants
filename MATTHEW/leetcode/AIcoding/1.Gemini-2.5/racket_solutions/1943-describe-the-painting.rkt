#lang racket

(define (describe-the-painting segments)
  (define events-map (make-hash))

  (for-each (lambda (segment)
              (define start (car segment))
              (define end (cadr segment))
              (define color (caddr segment))
              (hash-set! events-map start (cons color (hash-ref events-map start '())))
              (hash-set! events-map end (cons (- color) (hash-ref events-map end '()))))
            segments)

  (define sorted-coords (sort (hash-keys events-map) <))

  (define result '())
  (define current-color-sum 0)
  (define prev-coord (car sorted-coords))

  (for-each (lambda (curr-coord)
              (when (and (!= prev-coord curr-coord) (> current-color-sum 0))
                (set! result (cons (list prev-coord curr-coord current-color-sum) result)))

              (for-each (lambda (change)
                          (set! current-color-sum (+ current-color-sum change)))
                        (hash-ref events-map curr-coord '()))

              (set! prev-coord curr-coord))
            sorted-coords)

  (reverse result))