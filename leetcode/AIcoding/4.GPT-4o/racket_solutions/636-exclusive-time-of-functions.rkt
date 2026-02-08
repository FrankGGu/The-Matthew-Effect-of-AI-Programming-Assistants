(define (exclusiveTime n logs)
  (define result (make-vector n 0))
  (define stack '())
  (define prev-time 0)

  (for-each 
    (lambda (log)
      (define parts (string-split log "[ :]+"))
      (define id (string->number (vector-ref parts 0)))
      (define type (vector-ref parts 1))
      (define time (string->number (vector-ref parts 2)))

      (cond
        [(equal? type "start")
         (when (not (null? stack))
           (vector-set! result (car stack) (+ (vector-ref result (car stack)) (- time prev-time))))
         (set! prev-time time)
         (set! stack (cons id stack))]
        [(equal? type "end")
         (vector-set! result id (+ (vector-ref result id) (+ 1 (- time prev-time))))
         (set! prev-time (+ time 1))
         (set! stack (cdr stack))]))
    logs)

  (vector->list result))