(define (people-aware-of-secret n delay forget)
  (let loop ([day 1] [aware 0] [sharing 0] [queue (make-queue)])
    (if (> day n)
        (modulo aware 1000000007)
        (let* ([new-sharing (if (>= day delay) (queue-front queue) 0)]
               [new-aware (+ aware new-sharing (- (if (>= day forget) (queue-front queue) 0)))]
               [new-queue (if (>= day delay) (queue-remove queue) queue)]
               [new-queue (if (>= day delay) (queue-add new-queue new-sharing) new-queue)])
          (loop (add1 day) new-aware new-sharing new-queue)))))

(define (make-queue) '())
(define (queue-front q) (if (null? q) 0 (car q)))
(define (queue-remove q) (if (null? q) q (cdr q)))
(define (queue-add q val) (append q (list val)))