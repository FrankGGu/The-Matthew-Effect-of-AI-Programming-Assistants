(define (smallest-chair times target)
  (define n (length times))
  (define arrival (make-vector n 0))
  (define leave (make-vector n 0))
  (define chairs (make-hash))
  (define available (make-pq <))

  (for ([i (in-range n)])
    (vector-set! arrival i (list-ref (list-ref times i) 0))
    (vector-set! leave i (list-ref (list-ref times i) 1)))

  (define events '())
  (for ([i (in-range n)])

  (for ([i (in-range n)])
    (set! events (cons (list (vector-ref arrival i) 1 i) events))
    (set! events (cons (list (vector-ref leave i) 0 i) events))

  (set! events (sort events (lambda (a b) (< (car a) (car b)))))

  (for ([i (in-range n)])
    (pq-push! available i))

  (for ([event events])
    (define time (car event))
    (define typ (cadr event))
    (define idx (caddr event))
    (if (= typ 1)
        (let ([chair (pq-pop! available)])
          (hash-set! chairs idx chair)
          (if (= idx target) chair (void)))
        (let ([chair (hash-ref chairs idx)])
          (pq-push! available chair))))

  -1)