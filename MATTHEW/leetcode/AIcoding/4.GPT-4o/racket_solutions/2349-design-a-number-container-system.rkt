#lang racket

(struct container (index num) #:transparent)

(define NumberContainer
  (struct: container (index num)))

(define (make-number-container)
  (define numbers (make-hash))
  (define indices (make-hash))

  (define (change num index)
    (define old-index (hash-ref numbers num #f))
    (when old-index
      (hash-set! indices old-index (remove old-index (hash-ref indices old-index '()))))
      (hash-remove! numbers num))
    (when index
      (hash-set! numbers num index)
      (hash-set! indices index (cons num (hash-ref indices index '())))))

  (define (add num)
    (change num (add1 (hash-ref (hash-ref indices num '()) 0))))

  (define (remove num)
    (change num (hash-ref numbers num #f)))

  (define (find num)
    (hash-ref numbers num #f))

  (define (find_first())
    (define min-index (apply min (hash-keys indices)))
    (define nums (hash-ref indices min-index '()))
    (when (not (null? nums))
      (first nums)))

  (define (find_last())
    (define max-index (apply max (hash-keys indices)))
    (define nums (hash-ref indices max-index '()))
    (when (not (null? nums))
      (first nums)))

  (define (get-structure)
    (list add remove find find_first find_last))

  (get-structure))