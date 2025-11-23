(struct MyCircularQueue (data capacity front rear size) #:mutable)

(define (MyCircularQueue k)
  (MyCircularQueue (make-vector k 0) k 0 -1 0))

(define (enQueue this value)
  (if (isFull this)
      #f
      (begin
        (set-MyCircularQueue-rear! this (modulo (+ (MyCircularQueue-rear this) 1) (MyCircularQueue-capacity this)))
        (vector-set! (MyCircularQueue-data this) (MyCircularQueue-rear this) value)
        (set-MyCircularQueue-size! this (+ (MyCircularQueue-size this) 1))
        #t)))

(define (deQueue this)
  (if (isEmpty this)
      #f
      (begin
        (set-MyCircularQueue-front! this (modulo (+ (MyCircularQueue-front this) 1) (MyCircularQueue-capacity this)))
        (set-MyCircularQueue-size! this (- (MyCircularQueue-size this) 1))
        #t)))

(define (Front this)
  (if (isEmpty this)
      -1
      (vector-ref (MyCircularQueue-data this) (MyCircularQueue-front this))))

(define (Rear this)
  (if (isEmpty this)
      -1
      (vector-ref (MyCircularQueue-data this) (MyCircularQueue-rear this))))

(define (isEmpty this)
  (= (MyCircularQueue-size this) 0))

(define (isFull this)
  (= (MyCircularQueue-size this) (MyCircularQueue-capacity this)))