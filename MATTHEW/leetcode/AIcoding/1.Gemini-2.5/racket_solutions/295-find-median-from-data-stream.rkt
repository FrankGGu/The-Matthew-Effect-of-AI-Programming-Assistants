#lang racket/base

(struct heap (data comparator current-size) #:mutable)

(define (heap-parent i) (floor (/ (- i 1) 2)))
(define (heap-left i) (+ (* 2 i) 1))
(define (heap-right i) (+ (* 2 i) 2))

(define (heap-swap! h i j)
  (let ([data (heap-data h)])
    (let ([temp (vector-ref data i)])
      (vector-set! data i (vector-ref data j))
      (vector-set! data j temp))))

(define (heap-heapify-up! h i)
  (let ([data (heap-data h)]
        [comparator (heap-comparator h)]
        [p (heap-parent i)])
    (when (and (> i 0) (comparator (vector-ref data i) (vector-ref data p)))
      (heap-swap! h i p)
      (heap-heapify-up! h p))))

(define (heap-heapify-down! h i)
  (let* ([data (heap-data h)]
         [comparator (heap-comparator h)]
         [size (heap-current-size h)]
         [l (heap-left i)]
         [r (heap-right i)]
         [extreme-idx i])

    (when (and (< l size) (comparator (vector-ref data l) (vector-ref data extreme-idx)))
      (set! extreme-idx l))
    (when (and (< r size) (comparator (vector-ref data r) (vector-ref data extreme-idx)))
      (set! extreme-idx r))

    (when (not (= extreme-idx i))
      (heap-swap! h i extreme-idx)
      (heap-heapify-down! h extreme-idx))))

(define (make-heap comparator [initial-capacity 100000])
  (heap (make-vector initial-capacity) comparator 0))

(define (heap-add! h val)
  (let ([current-size (heap-current-size h)])
    (when (>= current-size (vector-length (heap-data h)))
      (error "Heap capacity exceeded."))
    (vector-set! (heap-data h) current-size val)
    (set-heap-current-size! h (+ current-size 1))
    (heap-heapify-up! h current-size)))

(define (heap-extract-min! h)
  (let ([current-size (heap-current-size h)])
    (when (zero? current-size) (error "Heap is empty"))
    (let ([top-val (vector-ref (heap-data h) 0)])
      (set-heap-current-size! h (- current-size 1))
      (when (> current-size 1)
        (heap-swap! h 0 current-size)
        (heap-heapify-down! h 0))
      top-val)))

(define (heap-min h)
  (when (zero? (heap-current-size h)) (error "Heap is empty"))
  (vector-ref (heap-data h) 0))

(define (heap-count h)
  (heap-current-size h))

(define MedianFinder%
  (class object%
    (define max-heap (make-heap (lambda (a b) (> a b))))
    (define min-heap (make-heap (lambda (a b) (< a b))))

    (define/public (addNum num)
      (heap-add! max-heap num)

      (when (and (> (heap-count max-heap) 0)
                 (> (heap-count min-heap) 0)
                 (> (heap-min max-heap) (heap-min min-heap)))
        (heap-add! min-heap (heap-extract-min! max-heap)))

      (when (> (- (heap-count max-heap) (heap-count min-heap)) 1)
        (heap-add! min-heap (heap-extract-min! max-heap)))
      (when (> (- (heap-count min-heap) (heap-count max-heap)) 0)
        (heap-add! max-heap (heap-extract-min! min-heap))))

    (define/public (findMedian)
      (if (= (heap-count max-heap) (heap-count min-heap))
          (/ (+ (heap-min max-heap) (heap-min min-heap)) 2.0)
          (heap-min max-heap)))

    (super-new)))