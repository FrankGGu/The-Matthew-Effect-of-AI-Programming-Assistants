(define kth-largest%
  (class object%
    (super-new)
    (init-field k nums)
    (field [heap (make-heap (lambda (a b) (< a b))])

    (define/public (add val)
      (heap-add! heap val)
      (when (> (heap-count heap) k)
        (heap-remove-min! heap))
      (heap-min heap))

    (for ([num nums])
      (add num))))

(define (make-heap cmp)
  (let ([heap (vector)])
    (lambda (msg . args)
      (case msg
        [(add!) (let ([val (car args)])
                  (set! heap (vector-append heap (vector val)))
                  (heapify-up heap (sub1 (vector-length heap)) cmp))]
        [(remove-min!) (let ([min (vector-ref heap 0)])
                         (vector-set! heap 0 (vector-ref heap (sub1 (vector-length heap))))
                         (set! heap (vector-take heap (sub1 (vector-length heap))))
                         (heapify-down heap 0 cmp)
                         min)]
        [(min) (vector-ref heap 0)]
        [(count) (vector-length heap)]
        [else (error "Unknown message")]))))

(define (heapify-up heap i cmp)
  (let ([parent (quotient (sub1 i) 2)])
    (when (and (>= i 1) (cmp (vector-ref heap i) (vector-ref heap parent)))
      (vector-swap! heap i parent)
      (heapify-up heap parent cmp))))

(define (heapify-down heap i cmp)
  (let* ([left (+ (* i 2) 1)]
         [right (+ (* i 2) 2)]
         [smallest i])
    (when (and (< left (vector-length heap)) (cmp (vector-ref heap left) (vector-ref heap smallest)))
      (set! smallest left))
    (when (and (< right (vector-length heap)) (cmp (vector-ref heap right) (vector-ref heap smallest)))
      (set! smallest right))
    (when (not (= smallest i))
      (vector-swap! heap i smallest)
      (heapify-down heap smallest cmp)))

(define (vector-swap! vec i j)
  (let ([tmp (vector-ref vec i)])
    (vector-set! vec i (vector-ref vec j))
    (vector-set! vec j tmp)))

(define (vector-take vec n)
  (vector-copy vec 0 n))