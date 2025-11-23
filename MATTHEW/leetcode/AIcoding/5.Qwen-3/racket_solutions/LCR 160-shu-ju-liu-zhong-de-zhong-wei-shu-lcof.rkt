#lang racket

(define-struct heap (data compare)
  #:mutable)

(define (make-heap compare)
  (make-heap '() compare))

(define (heap-empty? h)
  (null? (heap-data h)))

(define (heap-size h)
  (length (heap-data h)))

(define (heap-top h)
  (car (heap-data h)))

(define (heap-insert h x)
  (set-heap-data! h (cons x (heap-data h)))
  (set-heap-data! h (sort (heap-data h) (heap-compare h))))

(define (heap-extract-top h)
  (let ((top (heap-top h)))
    (set-heap-data! h (cdr (heap-data h)))
    top))

(define (medianFinder)
  (let* ((low (make-heap >))
         (high (make-heap <)))
    (lambda (x)
      (if (or (heap-empty? low) (> x (heap-top low)))
          (heap-insert high x)
          (heap-insert low x))
      (when (> (heap-size low) (+ (heap-size high) 1))
        (heap-insert high (heap-extract-top low)))
      (when (> (heap-size high) (heap-size low))
        (heap-insert low (heap-extract-top high)))
      (if (= (heap-size low) (heap-size high))
          (/ (+ (heap-top low) (heap-top high)) 2)
          (heap-top low)))))

(define (main)
  (define mf (medianFinder))
  (printf "~a~n" (mf 1))
  (printf "~a~n" (mf 2))
  (printf "~a~n" (mf 3))
  (printf "~a~n" (mf 4))
  (printf "~a~n" (mf 5))
  (printf "~a~n" (mf 6)))

(main)