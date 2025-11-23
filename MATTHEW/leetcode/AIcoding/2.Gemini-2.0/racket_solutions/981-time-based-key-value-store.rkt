(define (make-time-map)
  (let ((data (make-hash)))
    (define (set key value timestamp)
      (let ((values (hash-ref data key '())))
        (hash-set! data key (cons (cons timestamp value) (filter (lambda (x) (< (car x) timestamp)) values)))))
    (define (get key timestamp)
      (let ((values (hash-ref data key '())))
        (let loop ((values values))
          (cond
            ((null? values) "")
            ((<= (caar values) timestamp) (cdar values))
            (else (loop (cdr values)))))))
    (define (dispatch method . args)
      (case method
        [(set) (apply set args)]
        [(get) (apply get args)]
        [else (error "invalid method")]))
    dispatch))