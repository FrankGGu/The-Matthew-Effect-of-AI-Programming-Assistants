(define (find-bubbles grid)
  (let loop ((g grid) (visited (make-vector (length grid) #f)) (result '()))
    (if (null? g)
        result
        (let* ((row (car g))
               (col (length row))
               (next (cdr g)))
          (if (and (not (vector-ref visited (car row)))
                   (not (equal? (car row) 0)))
              (begin
                (vector-set! visited (car row) #t)
                (set! result (cons (car row) result))))
          (loop next visited result))))))