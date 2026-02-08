(define-struct OrderedStream (ptr stream))

(define (OrderedStream constructor n)
  (define stream (make-vector n '()))
  (define ptr 0)
  (define (insert id value)
    (vector-set! stream (- id 1) value)
    (let loop ((start ptr) (result '()))
      (if (and (< start n) (not (equal? (vector-ref stream start) '())))
          (begin
            (set! ptr (+ start 1))
            (loop ptr (cons (vector-ref stream start) result)))
          (if (null? result)
              '()
              (reverse result)))))
  (values insert))

(define (createOrderedStream n)
  (OrderedStream n))

(define (insert stream id value)
  (let-values ([(insert-fn) (stream)])
    (insert-fn id value)))

(define (get stream)
  (let-values ([(insert-fn) (stream)])
    (insert-fn)))