#lang racket

(define (max-building n restrictions)
  (define sorted-res (sort (cons (list 1 0) restrictions) (lambda (a b) (< (car a) (car b))))
  (define m (length sorted-res))

  (for ([i (in-range 1 m)])
    (define prev-id (first (list-ref sorted-res (- i 1)))
    (define prev-h (second (list-ref sorted-res (- i 1))))
    (define curr-id (first (list-ref sorted-res i)))
    (define curr-h (second (list-ref sorted-res i)))
    (set! curr-h (min curr-h (+ prev-h (- curr-id prev-id))))
    (set-list-ref! sorted-res i (list curr-id curr-h)))

  (for ([i (in-range (- m 2) -1 -1)])
    (define next-id (first (list-ref sorted-res (+ i 1))))
    (define next-h (second (list-ref sorted-res (+ i 1))))
    (define curr-id (first (list-ref sorted-res i)))
    (define curr-h (second (list-ref sorted-res i)))
    (set! curr-h (min curr-h (+ next-h (- next-id curr-id))))
    (set-list-ref! sorted-res i (list curr-id curr-h)))

  (define max-h 0)
  (for ([i (in-range 1 m)])
    (define left-id (first (list-ref sorted-res (- i 1))))
    (define left-h (second (list-ref sorted-res (- i 1))))
    (define right-id (first (list-ref sorted-res i)))
    (define right-h (second (list-ref sorted-res i)))
    (define current-max (+ (max left-h right-h) (quotient (+ (- right-id left-id) (abs (- left-h right-h))) 2)))
    (set! max-h (max max-h current-max)))

  (max max-h (- n (first (last sorted-res)) (second (last sorted-res)))))