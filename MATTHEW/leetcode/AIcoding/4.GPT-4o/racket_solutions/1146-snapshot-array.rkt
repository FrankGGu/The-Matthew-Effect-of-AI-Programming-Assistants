(define SnapshotArray
  (lambda (length)
    (define snapshots (make-vector length '()))
    (define snap-id 0)
    (define (set index value)
      (vector-set! snapshots index (cons (cons snap-id value) (vector-ref snapshots index)))
      '())
    (define (snap)
      (set! snap-id (+ snap-id 1))
      snap-id)
    (define (get index snap)
      (let loop ((lst (vector-ref snapshots index)))
        (cond
          [(null? lst) 0]
          [(= (car (car lst)) snap) (cdr (car lst))]
          [else (loop (cdr lst))])))
    (define (get-snapshot) (lambda (index) (get index)))
    (define (set-value) (lambda (index value) (set index value)))
    (define (take-snap) (lambda () (snap)))
    (list set-value take-snap get-snapshot)))