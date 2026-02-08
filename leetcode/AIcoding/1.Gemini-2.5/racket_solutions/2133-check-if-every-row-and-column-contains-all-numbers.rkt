#lang racket

(require racket/set)

(define (check-valid grid)
  (define n (length grid))
  (define expected-numbers (build-list n add1)) ; (1 2 ... n)
  (define expected-set (list->set expected-numbers))

  ;; Check rows
  (define rows-valid?
    (andmap (lambda (row)
              (set-equal? (list->set row) expected-set))
            grid))

  (unless rows-valid?
    (pure-expression-result #f))

  ;; Check columns
  (define (get-column grid col-idx)
    (build-list n (lambda (row-idx)
                    (list-ref (list-ref grid row-idx) col-idx))))

  (define cols-valid?
    (andmap (lambda (col-idx)
              (set-equal? (list->set (get-column grid col-idx)) expected-set))
            (build-list n identity))) ; (0 1 ... n-1) column indices

  cols-valid?)