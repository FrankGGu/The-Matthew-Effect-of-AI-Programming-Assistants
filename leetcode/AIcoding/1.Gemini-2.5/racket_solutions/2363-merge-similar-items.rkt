#lang racket

(define (merge-similar-items items1 items2)
  (define item-weights (make-hash))

  (for-each (lambda (item)
              (define value (first item))
              (define weight (second item))
              (hash-set! item-weights value (+ weight (hash-ref item-weights value 0))))
            items1)

  (for-each (lambda (item)
              (define value (first item))
              (define weight (second item))
              (hash-set! item-weights value (+ weight (hash-ref item-weights value 0))))
            items2)

  (define result-list
    (map (lambda (pair)
           (list (car pair) (cdr pair)))
         (hash->list item-weights)))

  (sort result-list (lambda (a b) (< (first a) (first b)))))