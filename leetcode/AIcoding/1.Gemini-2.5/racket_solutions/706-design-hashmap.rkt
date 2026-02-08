#lang racket

(define (MyHashMap)
  (define capacity 10007)
  (define buckets (make-vector capacity '()))

  (define (hash-key key)
    (remainder key capacity))

  (define (put key value)
    (define idx (hash-key key))
    (define current-bucket (vector-ref buckets idx))

    (define found-and-updated #f)
    (define new-bucket
      (for/list ([pair current-bucket])
        (if (= (car pair) key)
            (begin (set! found-and-updated #t) (cons key value))
            pair)))

    (unless found-and-updated
      (set! new-bucket (cons (cons key value) new-bucket)))

    (vector-set! buckets idx new-bucket))

  (define (get key)
    (define idx (hash-key key))
    (define current-bucket (vector-ref buckets idx))

    (define found-pair (findf (lambda (pair) (= (car pair) key)) current-bucket))
    (if found-pair
        (cdr found-pair)
        -1))

  (define (remove key)
    (define idx (hash-key key))
    (define current-bucket (vector-ref buckets idx))

    (define new-bucket (filter (lambda (pair) (not (= (car pair) key))) current-bucket))
    (vector-set! buckets idx new-bucket))

  (lambda (method-name . args)
    (case method-name
      [(put) (apply put args)]
      [(get) (apply get args)]
      [(remove) (apply remove args)]
      [else (error "Unknown method" method-name)])))