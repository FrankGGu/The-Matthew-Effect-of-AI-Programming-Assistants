#lang racket

(require data/heap)

(define (find-all-people n meetings first-person)
  (define earliest-known (make-vector n +inf.0))
  (vector-set! earliest-known first-person 0)
  (vector-set! earliest-known 0 0)

  (define adj (make-vector n '()))
  (for ([m meetings])
    (define x (first m))
    (define y (second m))
    (define t (third m))
    (vector-set! adj x (cons (cons y t) (vector-ref adj x)))
    (vector-set! adj y (cons (cons x t) (vector-ref adj y))))

  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! heap (cons 0 0))
  (heap-add! heap (cons 0 first-person))

  (let loop ()
    (unless (heap-empty? heap)
      (define current (heap-min heap))
      (heap-remove-min! heap)
      (define current-time (car current))
      (define current-person (cdr current))
      (when (<= current-time (vector-ref earliest-known current-person))
        (for ([neighbor (vector-ref adj current-person)])
          (define next-person (car neighbor))
          (define meeting-time (cdr neighbor))
          (define new-time (max current-time meeting-time))
          (when (< new-time (vector-ref earliest-known next-person))
            (vector-set! earliest-known next-person new-time)
            (heap-add! heap (cons new-time next-person)))))
      (loop)))

  (for/list ([i (in-range n)]
             #:when (not (equal? (vector-ref earliest-known i) +inf.0)))
    i))