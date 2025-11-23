(define recent-counter%
  (class object%
    (super-new)
    (init-field [queue (make-queue)])

    (define/public (ping t)
      (enqueue! queue t)
      (let loop ()
        (if (< (front queue) (- t 3000))
            (begin
              (dequeue! queue)
              (loop))
            (queue-length queue))))))

(define (make-queue)
  (let ([front-ptr null]
        [rear-ptr null])
    (lambda (msg . args)
      (case msg
        [(empty?) (null? front-ptr)]
        [(enqueue!) 
         (let ([new-pair (mcons (car args) null)])
         (if (null? front-ptr)
             (begin
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair))
             (begin
               (set-mcdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)))]
        [(dequeue!) 
         (if (null? front-ptr)
             (error "dequeue! empty queue")
             (set! front-ptr (mcdr front-ptr)))]
        [(front) 
         (if (null? front-ptr)
             (error "front empty queue")
             (mcar front-ptr))]
        [(length) 
         (let loop ([lst front-ptr] [count 0])
           (if (null? lst)
               count
               (loop (mcdr lst) (add1 count))))]))))

(define (enqueue! q x) (q 'enqueue! x))
(define (dequeue! q) (q 'dequeue!))
(define (front q) (q 'front))
(define (queue-empty? q) (q 'empty?))
(define (queue-length q) (q 'length))