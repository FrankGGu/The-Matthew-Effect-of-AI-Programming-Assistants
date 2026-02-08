(define (my-calendar-ii)
  (let ([events (make-vector 0 '())]
        [overlaps (make-vector 0 '())])
    (define (book start end)
      (let loop ([overlaps-list (vector->list overlaps)])
        (cond
          [(null? overlaps-list)
           (for/and ([event (in-vector events)])
             (not (or (> start (car (cdr event)))
                      (< end (car event)))))
           (begin
             (vector-set! events (vector-length events) (cons start (cons end '())))
             (vector-set! overlaps (vector-length overlaps) '())
             #t)]
          [else
           (let ([overlap (car overlaps-list)])
             (if (or (> start (car (cdr overlap)))
                     (< end (car overlap)))
                 (loop (cdr overlaps-list))
                 #f))]))
    (define (add-event start end)
      (if (book start end)
          #t
          #f))
    (lambda (method . args)
      (case method
        [(init)
         (begin
           (set! events (make-vector 0 '()))
           (set! overlaps (make-vector 0 '()))
           '())]
        [(book)
         (add-event (car args) (cadr args))]
        [else
         (error "Invalid method")]))))