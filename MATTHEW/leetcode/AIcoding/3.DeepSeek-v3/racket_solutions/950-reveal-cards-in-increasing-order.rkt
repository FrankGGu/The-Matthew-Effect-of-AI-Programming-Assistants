(define (deck-revealed-increasing deck)
  (let* ([sorted-deck (sort deck <)]
         [n (length sorted-deck)]
         [result (make-vector n 0)]
         [queue (make-queue)])
    (for ([i (in-range n)])
      (enqueue! queue i))
    (for ([card (in-list sorted-deck)])
      (vector-set! result (dequeue! queue) card)
      (unless (queue-empty? queue)
        (enqueue! queue (dequeue! queue))))
    (vector->list result)))

(define (make-queue) (mcons null null))
(define (queue-empty? q) (null? (mcar q)))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (list x)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr q) (list x)) (set-mcdr! q (mcdr (mcdr q))))))
(define (dequeue! q)
  (let ([x (car (mcar q))])
    (set-mcar! q (cdr (mcar q)))
    (when (null? (mcar q)) (set-mcdr! q null))
    x))