(define (FrontMiddleBackQueue)
  (define queue '())

  (define (pushFront x)
    (set! queue (cons x queue)))

  (define (pushMiddle x)
    (let* ((mid (quotient (length queue) 2)))
      (set! queue (append (take queue mid) (cons x (drop queue mid))))))

  (define (pushBack x)
    (set! queue (append queue (list x))))

  (define (popFront)
    (if (null? queue)
        -1
        (let ((front (car queue)))
          (set! queue (cdr queue))
          front)))

  (define (popMiddle)
    (if (null? queue)
        -1
        (let* ((mid (quotient (length queue) 2))
               (middle (list-ref queue mid)))
          (set! queue (append (take queue mid) (drop queue (+ mid 1))))
          middle)))

  (define (popBack)
    (if (null? queue)
        -1
        (let ((back (last queue)))
          (set! queue (butlast queue))
          back)))

  (lambda ()
    (define (pushFront x) (pushFront x))
    (define (pushMiddle x) (pushMiddle x))
    (define (pushBack x) (pushBack x))
    (define (popFront) (popFront))
    (define (popMiddle) (popMiddle))
    (define (popBack) (popBack))
    (list pushFront pushMiddle pushBack popFront popMiddle popBack)))

(define q (FrontMiddleBackQueue))
((q 0) 1) ; pushFront(1)
((q 1) 2) ; pushBack(2)
((q 1) 3) ; pushMiddle(3)
((q 0)) ; popFront() -> returns 1
((q 1)) ; popMiddle() -> returns 3
((q 0)) ; popBack() -> returns 2