#lang racket

(struct MyHashSet () #:transparent)

(define MyHashSet/make
  (lambda ()
    (let ([buckets (make-vector 1000 #f)])
      (define (add key)
        (define idx (modulo key (vector-length buckets)))
        (define bucket (vector-ref buckets idx))
        (if (not bucket)
          (vector-set! buckets idx (make-vector 1000 #f)))
        (define bucket (vector-ref buckets idx))
        (vector-set! bucket (modulo key 1000) #t))

      (define (remove key)
        (define idx (modulo key (vector-length buckets)))
        (define bucket (vector-ref buckets idx))
        (when bucket
          (vector-set! bucket (modulo key 1000) #f)))

      (define (contains key)
        (define idx (modulo key (vector-length buckets)))
        (define bucket (vector-ref buckets idx))
        (and bucket (vector-ref bucket (modulo key 1000))))

      (define (get)
        (list 'MyHashSet))

      (define (set! obj)
        (set! obj (MyHashSet)))

      (define (get-add)
        (lambda (key) (add key)))

      (define (get-remove)
        (lambda (key) (remove key)))

      (define (get-contains)
        (lambda (key) (contains key)))

      (define (get-buckets)
        buckets)

      (define (self)
        (list (get-add) (get-remove) (get-contains)))

      (self))))