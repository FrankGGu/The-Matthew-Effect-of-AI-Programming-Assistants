(define-struct Interval (start end))

(define (SummaryRanges)
  (define intervals '())

  (define (addNum num)
    (define new-interval (make-Interval num num))
    (set! intervals (insert-interval intervals new-interval)))

  (define (insert-interval lst new-interval)
    (cond
      [(null? lst) (list new-interval)]
      [(< (Interval-start (car lst)) (Interval-start new-interval)) 
       (cons (car lst) (insert-interval (cdr lst) new-interval))]
      [(= (Interval-end (car lst)) (- (Interval-start new-interval) 1)) 
       (cons (make-Interval (Interval-start (car lst)) (Interval-end new-interval)) (cdr lst))]
      [(= (Interval-start new-interval) (+ (Interval-end (car lst)) 1)) 
       (cons (make-Interval (Interval-start (car lst)) (Interval-end new-interval)) (cdr lst))]
      [else 
       (cons (car lst) (insert-interval (cdr lst) new-interval))]))

  (define (getIntervals)
    intervals)

  (define (reset)
    (set! intervals '()))

  (define (make-SummaryRanges)
    (lambda (cmd . args)
      (cond
        [(equal? cmd 'addNum) (apply addNum args)]
        [(equal? cmd 'getIntervals) (getIntervals)]
        [(equal? cmd 'reset) (reset)])))
)

(define SummaryRanges (make-SummaryRanges))