(struct circular-queue (vec front rear size)
  #:mutable
  #:transparent)

(define (make-my-circular-queue k)
  (circular-queue (make-vector k) -1 -1 0))

(define (my-circular-queue-enqueue queue value)
  (if (my-circular-queue-is-full? queue)
      #f
      (begin
        (set-circular-queue-rear! queue (modulo (+ (circular-queue-rear queue) 1) (vector-length (circular-queue-vec queue))))
        (vector-set! (circular-queue-vec queue) (circular-queue-rear queue) value)
        (set-circular-queue-size! queue (+ (circular-queue-size queue) 1))
        (when (= (circular-queue-front queue) -1)
          (set-circular-queue-front! queue (circular-queue-rear queue)))
        #t)))

(define (my-circular-queue-dequeue queue)
  (if (my-circular-queue-is-empty? queue)
      #f
      (begin
        (let ([val (vector-ref (circular-queue-vec queue) (circular-queue-front queue))])
          (set-circular-queue-front! queue (modulo (+ (circular-queue-front queue) 1) (vector-length (circular-queue-vec queue))))
          (set-circular-queue-size! queue (- (circular-queue-size queue) 1))
          (when (= (circular-queue-size queue) 0)
            (set-circular-queue-front! queue -1)
            (set-circular-queue-rear! queue -1))
          #t)))

(define (my-circular-queue-front queue)
  (if (my-circular-queue-is-empty? queue)
      -1
      (vector-ref (circular-queue-vec queue) (circular-queue-front queue))))

(define (my-circular-queue-rear queue)
  (if (my-circular-queue-is-empty? queue)
      -1
      (vector-ref (circular-queue-vec queue) (circular-queue-rear queue))))

(define (my-circular-queue-is-empty? queue)
  (= (circular-queue-size queue) 0))

(define (my-circular-queue-is-full? queue)
  (= (circular-queue-size queue) (vector-length (circular-queue-vec queue))))