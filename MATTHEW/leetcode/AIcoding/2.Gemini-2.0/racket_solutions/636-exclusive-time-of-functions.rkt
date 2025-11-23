(define (exclusive-time n logs)
  (define result (make-vector n 0))
  (define stack '())
  (define prev-time 0)

  (for ([log logs])
    (define parts (string-split log ":"))
    (define func-id (string->number (car parts)))
    (define type (cadr parts))
    (define timestamp (string->number (caddr parts)))

    (if (equal? type "start")
        (begin
          (when (not (empty? stack))
            (vector-set! result (car stack) (+ (vector-ref result (car stack)) (- timestamp prev-time))))
          (set! stack (cons func-id stack))
          (set! prev-time timestamp))
        (begin
          (define popped (car stack))
          (set! stack (cdr stack))
          (vector-set! result popped (+ (vector-ref result popped) (- timestamp prev-time) 1))
          (set! prev-time (+ timestamp 1)))))

  result)