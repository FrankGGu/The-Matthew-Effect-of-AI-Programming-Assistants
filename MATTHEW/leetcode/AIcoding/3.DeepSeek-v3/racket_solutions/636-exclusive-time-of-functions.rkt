(define (exclusive-time n logs)
  (let ([stack '()]
        [res (make-vector n 0)]
        [prev-time 0])
    (for ([log (in-list logs)])
      (let* ([parts (string-split log ":")]
             [id (string->number (first parts))]
             [type (second parts)]
             [time (string->number (third parts))])
        (if (equal? type "start")
            (begin
              (when (not (null? stack))
                (let ([top-id (car (car stack))])
                (vector-set! res top-id (+ (vector-ref res top-id) (- time prev-time))))
              (set! stack (cons (cons id time) stack))
              (set! prev-time time))
            (begin
              (let ([top (car stack)])
                (vector-set! res (car top) (+ (vector-ref res (car top)) (- (+ time 1) prev-time)))
                (set! stack (cdr stack))
                (set! prev-time (+ time 1)))))))
    (vector->list res)))