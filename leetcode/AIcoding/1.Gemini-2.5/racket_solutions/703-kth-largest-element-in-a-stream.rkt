#lang racket

(define (kth-largest-element k nums)
  (define heap (make-vector k #f))
  (define heap-size 0)

  (define (swap! i j)
    (let ([temp (vector-ref heap i)])
      (vector-set! heap i (vector-ref heap j))
      (vector-set! heap j temp)))

  (define (heapify-up! idx)
    (let loop ([i idx])
      (let ([parent (floor (/ (- i 1) 2))])
        (when (and (> i 0) (< (vector-ref heap i) (vector-ref heap parent)))
          (swap! i parent)
          (loop parent)))))

  (define (heapify-down! idx)
    (let loop ([i idx])
      (let* ([left-child (+ (* 2 i) 1)]
             [right-child (+ (* 2 i) 2)]
             [smallest i])
        (when (and (< left-child heap-size) (< (vector-ref heap left-child) (vector-ref heap smallest)))
          (set! smallest left-child))
        (when (and (< right-child heap-size) (< (vector-ref heap right-child) (vector-ref heap smallest)))
          (set! smallest right-child))
        (when (not (= smallest i))
          (swap! i smallest)
          (loop smallest)))))

  (define (heap-add-element! val)
    (cond
      [(< heap-size k)
       (vector-set! heap heap-size val)
       (set! heap-size (+ heap-size 1))
       (heapify-up! (- heap-size 1))]
      [(> val (vector-ref heap 0))
       (vector-set! heap 0 val)
       (heapify-down! 0)]))

  (define (heap-peek-min)
    (vector-ref heap 0))

  (for-each heap-add-element! nums)

  (lambda (method . args)
    (case method
      [(add)
       (let ([val (car args)])
         (heap-add-element! val)
         (heap-peek-min))])))