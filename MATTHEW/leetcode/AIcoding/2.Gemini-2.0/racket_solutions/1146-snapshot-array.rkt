(define (SnapshotArray length)
  (let ([arr (make-vector length '())]
        [snap-id 0])
    (define (set-val index val)
      (vector-set! arr index (cons (cons snap-id val) (vector-ref arr index))))
    (define (get-val index)
      (let loop ([sn snap-id] [vals (vector-ref arr index)])
        (cond
          [(null? vals) 0]
          [(<= (car (car vals)) sn) (cdr (car vals))]
          [else (loop sn (cdr vals))])))
    (define (snap)
      (let ([current-snap-id snap-id])
        (set! snap-id (+ snap-id 1))
        current-snap-id))
    (define (get index snap-id)
      (let loop ([sn snap-id] [vals (vector-ref arr index)])
        (cond
          [(null? vals) 0]
          [(<= (car (car vals)) sn) (cdr (car vals))]
          [else (loop sn (cdr vals))])))
    (define (dispatch msg . args)
      (case msg
        [(set) (set-val (car args) (cadr args))]
        [(snap) (snap)]
        [(get) (get (car args) (cadr args))]
        [else (error "Invalid message")]))
    dispatch))