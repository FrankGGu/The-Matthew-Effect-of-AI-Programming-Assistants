#lang racket

(define HashMap
  (class object%
    (super-new)
    (define/override (initialize)
      (set! table (make-vector 10000 '()))
      (set! size 0))
    (define table (make-parameter '()))
    (define size (make-parameter 0))

    (define (hash key)
      (modulo (hash key) (vector-length table)))

    (define (find-key key lst)
      (for/or ([pair lst])
        (when (equal? (car pair) key)
          (cdr pair))))

    (define/public (put key value)
      (define index (hash key))
      (define lst (vector-ref table index))
      (define existing-value (find-key key lst))
      (if existing-value
          (set! lst (map (lambda (pair)
                           (if (equal? (car pair) key)
                               (cons key value)
                               pair)) lst))
          (set! lst (cons (cons key value) lst)))
      (vector-set! table index lst))

    (define/public (get key)
      (define index (hash key))
      (define lst (vector-ref table index))
      (define existing-value (find-key key lst))
      (if existing-value
          existing-value
          -1))

    (define/public (remove key)
      (define index (hash key))
      (define lst (vector-ref table index))
      (define new-lst (filter (lambda (pair) (not (equal? (car pair) key))) lst))
      (vector-set! table index new-lst))
    ))

(define hashmap (new HashMap))