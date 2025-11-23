#lang racket

(define-struct stream (ptr data))

(define (make-ordered-stream n)
  (let ([data (make-vector n #f)])
    (make-stream 0 data)))

(define (get-value s k)
  (if (and (<= k (vector-length (stream-data s))) (vector-ref (stream-data s) k))
      (vector-ref (stream-data s) k)
      #f))

(define (insert s k v)
  (vector-set! (stream-data s) k v)
  s)

(define (get-values s)
  (let loop ([i (stream-ptr s)])
    (if (or (>= i (vector-length (stream-data s))) (not (vector-ref (stream-data s) i)))
        '()
        (cons (vector-ref (stream-data s) i)
              (loop (+ i 1))))))

(define (set-ptr s i)
  (make-stream i (stream-data s)))