(define kth-largest%
  (class object%
    (super-new)
    (init-field k nums)
    (field [heap (make-heap (lambda (a b) (< a b)))])

    (define/public (add val)
      (heap-add! heap val)
      (when (> (heap-count heap) k)
        (heap-remove-min! heap))
      (heap-min heap))

    (begin
      (for ([num nums])
        (heap-add! heap num))
      (while (> (heap-count heap) k)
        (heap-remove-min! heap)))))

(define (make-heap cmp)
  (let ([heap '()])
    (lambda (msg . args)
      (case msg
        [(add) (let ([val (car args)])
                 (set! heap (cons val heap))
                 (heapify-up heap (sub1 (length heap)) cmp))]
        [(remove-min) (let ([min-val (car heap)])
                        (set! heap (append (cdr heap) (list (last heap))))
                        (heapify-down heap 0 cmp)
                        min-val)]
        [(min) (car heap)]
        [(count) (length heap)]
        [else (error "Unknown message")]))))

(define (heapify-up heap idx cmp)
  (let ([parent (quotient (sub1 idx) 2)])
    (when (and (>= parent 0) (cmp (list-ref heap idx) (list-ref heap parent)))
      (let ([temp (list-ref heap parent)])
        (list-set! heap parent (list-ref heap idx))
        (list-set! heap idx temp)
        (heapify-up heap parent cmp)))))

(define (heapify-down heap idx cmp)
  (let* ([left (+ (* 2 idx) 1)]
         [right (+ (* 2 idx) 2)]
         [smallest idx])
    (when (and (< left (length heap)) (cmp (list-ref heap left) (list-ref heap smallest)))
      (set! smallest left))
    (when (and (< right (length heap)) (cmp (list-ref heap right) (list-ref heap smallest)))
      (set! smallest right))
    (when (not (= smallest idx))
      (let ([temp (list-ref heap idx)])
        (list-set! heap idx (list-ref heap smallest))
        (list-set! heap smallest temp)
        (heapify-down heap smallest cmp)))))

(define (make-KthLargest k nums)
  (new kth-largest% [k k] [nums nums]))