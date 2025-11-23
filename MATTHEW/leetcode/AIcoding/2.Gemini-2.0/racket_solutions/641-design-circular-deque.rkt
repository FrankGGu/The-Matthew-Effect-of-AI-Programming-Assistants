(define (MyCircularDeque k)
  (struct deque (arr front rear size capacity) #:mutable)
  (deque (make-vector k #f) 0 0 0 k))

(define (insertFront obj value)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s c)
        #f
        (begin
          (set-deque-front! obj (modulo (- f 1) c))
          (vector-set! d (deque-front obj) value)
          (set-deque-size! obj (+ s 1))
          #t))))

(define (insertLast obj value)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s c)
        #f
        (begin
          (vector-set! d r value)
          (set-deque-rear! obj (modulo (+ r 1) c))
          (set-deque-size! obj (+ s 1))
          #t))))

(define (deleteFront obj)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s 0)
        #f
        (begin
          (set-deque-front! obj (modulo (+ f 1) c))
          (set-deque-size! obj (- s 1))
          #t))))

(define (deleteLast obj)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s 0)
        #f
        (begin
          (set-deque-rear! obj (modulo (- r 1) c))
          (set-deque-size! obj (- s 1))
          #t))))

(define (getFront obj)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s 0)
        -1
        (vector-ref d f))))

(define (getRear obj)
  (let ((d (deque-arr obj))
        (f (deque-front obj))
        (r (deque-rear obj))
        (s (deque-size obj))
        (c (deque-capacity obj)))
    (if (= s 0)
        -1
        (vector-ref d (modulo (- r 1) c)))))

(define (isEmpty obj)
  (let ((s (deque-size obj)))
    (= s 0)))

(define (isFull obj)
  (let ((s (deque-size obj))
        (c (deque-capacity obj)))
    (= s c)))