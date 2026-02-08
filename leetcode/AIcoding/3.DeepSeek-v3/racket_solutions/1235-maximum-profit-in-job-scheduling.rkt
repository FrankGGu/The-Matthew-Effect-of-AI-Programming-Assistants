(define (job-scheduling start end profit)
  (define jobs (sort (map list start end profit) (lambda (a b) (< (cadr a) (cadr b)))))
  (define n (length jobs))
  (define dp (make-vector (add1 n) 0))

  (define (binary-search right target)
    (let loop ([left 0] [right right])
      (if (>= left right)
          right
          (let ([mid (quotient (+ left right) 2)])
            (if (<= (cadr (list-ref jobs mid)) target)
                (loop (add1 mid) right)
                (loop left mid))))))

  (for ([i (in-range 1 (add1 n))])
    (let* ([job (list-ref jobs (sub1 i))]
           [start-time (car job)]
           [prev (binary-search (sub1 i) start-time)])
      (vector-set! dp i (max (vector-ref dp (sub1 i))
                             (+ (vector-ref dp prev) (caddr job)))))

  (vector-ref dp n))