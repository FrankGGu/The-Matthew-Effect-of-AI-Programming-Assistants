(define-struct queue (in out) #:mutable #:transparent)

(define (make-queue)
  (make-queue '() '()))

(define (push q x)
  (set-queue-in! q (cons x (queue-in q))))

(define (pop q)
  (if (null? (queue-out q))
      (begin
        (set-queue-out! q (reverse (queue-in q)))
        (set-queue-in! q '())
        (if (null? (queue-out q))
            (error "Queue is empty")
            (let ((x (car (queue-out q))))
              (set-queue-out! q (cdr (queue-out q)))
              x))
      (let ((x (car (queue-out q))))
        (set-queue-out! q (cdr (queue-out q)))
        x)))

(define (peek q)
  (if (null? (queue-out q))
      (begin
        (set-queue-out! q (reverse (queue-in q)))
        (set-queue-in! q '())
        (if (null? (queue-out q))
            (error "Queue is empty")
            (car (queue-out q))))
      (car (queue-out q))))

(define (empty q)
  (and (null? (queue-in q)) (null? (queue-out q))))