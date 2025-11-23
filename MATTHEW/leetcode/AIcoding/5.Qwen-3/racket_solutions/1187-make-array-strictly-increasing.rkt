#lang racket

(define (can-convert a b)
  (define (helper i j)
    (cond [(>= i (length a)) #t]
          [(>= j (length b)) #f]
          [else
           (if (= (list-ref a i) (list-ref b j))
               (helper (+ i 1) (+ j 1))
               (if (< (list-ref a i) (list-ref b j))
                   (helper (+ i 1) j)
                   (helper i (+ j 1))))]))
  (helper 0 0))

(define (get-indexes a b)
  (define (helper i j res)
    (cond [(>= i (length a)) res]
          [(>= j (length b)) res]
          [else
           (if (= (list-ref a i) (list-ref b j))
               (helper (+ i 1) (+ j 1) (cons j res))
               (if (< (list-ref a i) (list-ref b j))
                   (helper (+ i 1) j res)
                   (helper i (+ j 1) res)))]))
  (reverse (helper 0 0 '())))

(define (make-array-strictly-increasing a b)
  (define indexes (get-indexes a b))
  (define len (length a))
  (define dp (make-vector len 0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 len)])
    (define prev (vector-ref dp (- i 1)))
    (define idx (list-ref indexes i))
    (if (and (>= idx 0) (< (list-ref b idx) (list-ref a i)))
        (vector-set! dp i (+ prev 1))
        (vector-set! dp i prev)))
  (vector-ref dp (- len 1)))