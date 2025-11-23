(struct my-queue (in out) #:mutable)

(define (my-queue/new)
  (my-queue '() '()))

(define (my-queue/push q x)
  (set-my-queue-in! q (cons x (my-queue-in q))))

(define (my-queue/pop q)
  (if (empty? (my-queue-out q))
      (begin
        (set-my-queue-out! q (reverse (my-queue-in q)))
        (set-my-queue-in! q '()))
      '()))
  (define v (car (my-queue-out q)))
  (set-my-queue-out! q (cdr (my-queue-out q)))
  v)

(define (my-queue/peek q)
  (if (empty? (my-queue-out q))
      (begin
        (set-my-queue-out! q (reverse (my-queue-in q)))
        (set-my-queue-in! q '()))
      '()))
  (car (my-queue-out q)))

(define (my-queue/empty? q)
  (and (empty? (my-queue-in q)) (empty? (my-queue-out q))))