(define CircularQueue
  (lambda (k)
    (let ((queue (make-vector (+ k 1) 0))
          (front 0)
          (rear 0)
          (size 0)
          (capacity k))
      (define (enQueue(value)
        (if (= size capacity)
            #f
            (begin
              (vector-set! queue rear value)
              (set! rear (modulo (+ rear 1) (+ capacity 1)))
              (set! size (+ size 1))
              #t)))

      (define (deQueue)
        (if (= size 0)
            #f
            (begin
              (set! front (modulo (+ front 1) (+ capacity 1)))
              (set! size (- size 1))
              #t)))

      (define (Front)
        (if (= size 0)
            -1
            (vector-ref queue front)))

      (define (Rear)
        (if (= size 0)
            -1
            (vector-ref queue (modulo (- rear 1) (+ capacity 1)))))

      (define (isEmpty)
        (= size 0))

      (define (isFull)
        (= size capacity))

      (list enQueue deQueue Front Rear isEmpty isFull))))

(define myQueue (CircularQueue 3))
((car myQueue) 1) ; return true
((car myQueue) 2) ; return true
((car myQueue) 3) ; return true
((car myQueue) 4) ; return false, the queue is full
((caddr myQueue)) ; return 1
((caddr myQueue)) ; return true, dequeue 1
((car myQueue) 4) ; return true, enqueue 4
((caddr myQueue)) ; return 2
((caddr myQueue)) ; return true, dequeue 2
((caddr myQueue)) ; return 3
((caddr myQueue)) ; return true, dequeue 3
((caddr myQueue)) ; return 4
((caddr myQueue)) ; return true, dequeue 4
((caddr myQueue)) ; return -1
((cadddr myQueue)) ; return true
((cadddr myQueue)) ; return false