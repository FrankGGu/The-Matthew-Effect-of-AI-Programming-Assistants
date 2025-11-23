#lang racket/base

(define (heap-parent i) (floor (/ (- i 1) 2)))
(define (heap-left i) (+ (* 2 i) 1))
(define (heap-right i) (+ (* 2 i) 2))

(define (heapify! heap-vec i heap-size)
  (let loop ((current-i i))
    (let* ((l (heap-left current-i))
           (r (heap-right current-i))
           (largest current-i))
      (when (and (< l heap-size) (> (vector-ref heap-vec l) (vector-ref heap-vec largest)))
        (set! largest l))
      (when (and (< r heap-size) (> (vector-ref heap-vec r) (vector-ref heap-vec largest)))
        (set! largest r))
      (when (!= largest current-i)
        (let ((temp (vector-ref heap-vec current-i)))
          (vector-set! heap-vec current-i (vector-ref heap-vec largest))
          (vector-set! heap-vec largest temp))
        (loop largest)))))

(define (build-max-heap! heap-vec)
  (let ((heap-size (vector-length heap-vec)))
    (for ((i (range (floor (/ heap-size 2)) -1 -1)))
      (heapify! heap-vec i heap-size))))

(define (heap-extract-max! heap-vec heap-size-box)
  (let ((heap-size (unbox heap-size-box)))
    (let ((max-val (vector-ref heap-vec 0)))
      (set-box! heap-size-box (- heap-size 1)) ; Decrease heap size
      (let ((new-heap-size (unbox heap-size-box)))
        (when (> new-heap-size 0) ; Only heapify if there are elements left
          (vector-set! heap-vec 0 (vector-ref heap-vec new-heap-size)) ; Move last element to root
          (heapify! heap-vec 0 new-heap-size)))
      max-val)))

(define (heap-insert! heap-vec val heap-size-box)
  (let ((heap-size (unbox heap-size-box)))
    (set-box! heap-size-box (+ heap-size 1)) ; Increase heap size
    (let ((i (unbox heap-size-box))) ; New element goes to the end of the logical heap
      (vector-set! heap-vec (- i 1) val) ; Place at the new end of the vector
      (let loop ((current-i (- i 1)))
        (let ((parent (heap-parent current-i)))
          (when (and (> current-i 0) (< (vector-ref heap-vec parent) (vector-ref heap-vec current-i)))
            (let ((temp (vector-ref heap-vec current-i)))
              (vector-set! heap-vec current-i (vector-ref heap-vec parent))
              (vector-set! heap-vec parent temp))
            (loop parent)))))))

(define (is-possible target)
  (let* ((n (length target))
         (heap-vec (list->vector target)) ; Convert list to mutable vector for heap
         (heap-size (box n))             ; Box to hold mutable heap size
         (sum-total (apply + target)))    ; Initial sum of all elements

    ;; Edge case: n=1
    (when (= n 1)
      (if (= (vector-ref heap-vec 0) 1) #t #f))

    ;; Build initial max-heap
    (build-max-heap! heap-vec)

    ;; Main loop for reverse operations
    (let loop ()
      (let ((max-val (heap-extract-max! heap-vec heap-size)))

        ;; If the largest element is 1, all elements must be 1. We've reached the goal.
        (when (= max-val 1)
          #t)

        (let ((other-sum (- sum-total max-val)))
          (cond
            ;; If other-sum is 0, it means n=1. This case is handled above.
            ;; If we reach here, n > 1 and other-sum = 0, which is impossible.
            ((zero? other-sum) #f)
            ;; If max_val is not strictly greater than other_sum, it's impossible.
            ;; The value max_val was a sum, and the replaced value must be positive.
            ((<= max-val other-sum) #f)
            (else
             (let* ((new-val (modulo max-val other-sum)))
               (let ((final-new-val (if (zero? new-val) other-sum new-val)))
                 ;; The new value must be positive. If other-sum > 0, final-new-val will be > 0.
                 ;; This check is mostly for robustness.
                 (when (<= final-new-val 0) #f)

                 ;; Update total sum
                 (set! sum-total (+ other-sum final-new-val))
                 ;; Insert the new value back into the heap
                 (heap-insert! heap-vec final-new-val heap-size)
                 ;; Continue loop
                 (loop))))))))))