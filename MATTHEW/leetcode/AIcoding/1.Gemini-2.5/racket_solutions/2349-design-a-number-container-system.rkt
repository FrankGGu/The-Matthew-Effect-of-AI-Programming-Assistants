#lang racket

(struct number-container (index->number number->indices) #:mutable)

(define (number-container-change nc index number)
  (define index->number (number-container-index->number nc))
  (define number->indices (number-container-number->indices nc))

  (define old-number (hash-ref index->number index #f))

  (when (and old-number (not (= old-number number)))
    (define old-indices (hash-ref number->indices old-number (set)))
    (set! old-indices (set-remove old-indices index))
    (if (set-empty? old-indices)
        (hash-remove! number->indices old-number)
        (hash-set! number->indices old-number old-indices)))

  (hash-set! index->number index number)

  (define current-indices (hash-ref number->indices number (set)))
  (set! current-indices (set-add current-indices index))
  (hash-set! number->indices number current-indices))

(define (number-container-find nc number)
  (define number->indices (number-container-number->indices nc))
  (define indices (hash-ref number->indices number (set)))
  (if (set-empty? indices)
      -1
      (set-first indices)))

(define (make-number-container)
  (number-container (make-hash) (make-hash)))