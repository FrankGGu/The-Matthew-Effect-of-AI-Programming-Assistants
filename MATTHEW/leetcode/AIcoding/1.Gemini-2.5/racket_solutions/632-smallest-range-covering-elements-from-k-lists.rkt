#lang racket

(define (smallest-range nums)
  (define k (length nums))

  ;; A min-heap implementation using a mutable vector
  ;; Each element in the heap is a list: (value list-index element-index)
  (struct heap (data size) #:mutable)

  (define (heap-compare a b)
    (< (car a) (car b)))

  (define (heap-swap! h i j)
    (let ([temp (vector-ref (heap-data h) i)])
      (vector-set! (heap-data h) i (vector-ref (heap-data h) j))
      (vector-set! (heap-data h) j temp)))

  (define (heap-bubble-up! h idx)
    (let loop ([current-idx idx])
      (unless (= current-idx 0)
        (let ([parent-idx (floor (/ (- current-idx 1) 2))])
          (when (heap-compare (vector-ref (heap-data h) current-idx) (vector-ref (heap-data h) parent-idx))
            (heap-swap! h current-idx parent-idx)
            (loop parent-idx))))))

  (define (heap-bubble-down! h idx)
    (let loop ([current-idx idx])
      (let* ([left-child-idx (+ (* current-idx 2) 1)]
             [right-child-idx (+ (* current-idx 2) 2)]
             [smallest-idx current-idx])

        (when (and (< left-child-idx (heap-size h))
                   (heap-compare (vector-ref (heap-data h) left-child-idx) (vector-ref (heap-data h) smallest-idx)))
          (set! smallest-idx left-child-idx))

        (when (and (< right-child-idx (heap-size h))
                   (heap-compare (vector-ref (heap-data h) right-child-idx) (vector-ref (heap-data h) smallest-idx)))
          (set! smallest-idx right-child-idx))

        (unless (= smallest-idx current-idx)
          (heap-swap! h current-idx smallest-idx)
          (loop smallest-idx))))))

  (define (heap-push! h item)
    (when (= (heap-size h) (vector-length (heap-data h)))
      (let* ([old-vec (heap-data h)]
             [new-vec (make-vector (max 1 (* 2 (heap-size h))))])
        (vector-copy! new-vec 0 old-vec 0 (heap-size h))
        (set-heap-data! h new-vec)))
    (vector-set! (heap-data h) (heap-size h) item)
    (set-heap-size! h (+ (heap-size h) 1))
    (heap-bubble-up! h (- (heap-size h) 1)))

  (define (heap-pop! h)
    (when (= (heap-size h) 0) (error "Heap is empty"))
    (let ([min-item (vector-ref (heap-data h) 0)])
      (set-heap-size! h (- (heap-size h) 1))
      (when (> (heap-size h) 0)
        (vector-set! (heap-data h) 0 (vector-ref (heap-data h) (heap-size h)))
        (heap-bubble-down! h 0))
      min-item))

  (define (make-initial-heap capacity)
    (heap (make-vector capacity) 0))

  ;; --- Main logic ---
  (define current-heap (make-initial-heap k))
  (define max-val -inf.0)

  (for ([i (in-range k)])
    (let* ([list-i (list-ref nums i)]
           [first-elem (car list-i)])
      (heap-push! current-heap (list first-elem i 0))
      (set! max-val (max max-val first-elem))))

  (define min-range +inf.0)
  (define result-start 0)
  (define result-end 0)

  (let loop ()
    (when (= (heap-size current-heap) k)
      (let* ([min-elem (heap-pop! current-heap)]
             [val (car min-elem)]
             [list-idx (cadr min-elem)]
             [elem-idx (caddr min-elem)])

        (let ([current-diff (- max-val val)])
          (when (< current-diff min-range)
            (set! min-range current-diff)
            (set! result-start val)
            (set! result-end max-val))
          (when (and (= current-diff min-range) (< val result-start))
            (set! result-start val)
            (set! result-end max-val)))

        (let* ([current-list (list-ref nums list-idx)]
               [next-elem-idx (+ elem-idx 1)])
          (when (< next-elem-idx (length current-list))
            (let ([next-val (list-ref current-list next-elem-idx)])
              (heap-push! current-heap (list next-val list-idx next-elem-idx))
              (set! max-val (max max-val next-val))))
          (loop))))))

  (list result-start result-end))