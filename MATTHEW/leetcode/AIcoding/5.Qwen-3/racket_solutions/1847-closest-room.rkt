#lang racket

(define (closest-room rooms)
  (define (distance a b)
    (abs (- a b)))

  (define (process-queries queries)
    (for/fold ([result '()]
               [occupied #hash()])
      ([query queries])
      (match query
        [(list 'add room-id)
         (values result (hash-set occupied room-id #t))]
        [(list 'check room-id)
         (define available-rooms
           (filter (lambda (id) (not (hash-has-key? occupied id))) (hash-keys occupied)))
         (if (null? available-rooms)
             (values (append result '(#f)) occupied)
             (let* ([sorted-rooms (sort available-rooms (lambda (a b) (< (distance a room-id) (distance b room-id))))])
               (values (append result (list (car sorted-rooms))) occupied)))]
        [(list 'remove room-id)
         (values result (hash-remove occupied room-id))]))
    result))

  (process-queries (map (lambda (s) (string-split s)) (string-split rooms "\n"))))