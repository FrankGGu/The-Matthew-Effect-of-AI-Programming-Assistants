#lang racket

(define-struct queue (data front rear size capacity))

(define (make-queue capacity)
  (make-queue (make-vector capacity #f) 0 0 0 capacity))

(define (enqueue q item)
  (if (= (queue-size q) (queue-capacity q))
      #f
      (begin
        (vector-set! (queue-data q) (queue-rear q) item)
        (set-queue-rear! q (modulo (+ (queue-rear q) 1) (queue-capacity q)))
        (set-queue-size! q (+ (queue-size q) 1))
        #t)))

(define (dequeue q)
  (if (= (queue-size q) 0)
      #f
      (begin
        (let ((item (vector-ref (queue-data q) (queue-front q))))
          (set-queue-front! q (modulo (+ (queue-front q) 1) (queue-capacity q)))
          (set-queue-size! q (- (queue-size q) 1))
          item))))

(define (front q)
  (if (= (queue-size q) 0)
      #f
      (vector-ref (queue-data q) (queue-front q))))

(define (is-empty q)
  (= (queue-size q) 0))

(define (is-full q)
  (= (queue-size q) (queue-capacity q)))