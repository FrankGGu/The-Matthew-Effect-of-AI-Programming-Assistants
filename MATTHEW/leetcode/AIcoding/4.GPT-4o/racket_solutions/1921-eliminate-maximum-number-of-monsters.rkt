(define (eliminateMaximum dist speed)
  (define n (length dist))
  (define times (map (lambda (d s) (ceiling (/ d s))) dist speed))
  (define sorted-times (sort times <))
  (for/sum ([i (in-range n)])
    (if (>= (list-ref sorted-times i) i)
        1
        (begin
          (return "Not possible"))))
  n)

(define (eliminateMaximum dist speed)
  (define n (length dist))
  (define times (map (lambda (d s) (ceiling (/ d s))) dist speed))
  (define sorted-times (sort times <))
  (for ([i (in-range n)])
    (if (>= (list-ref sorted-times i) i)
        (begin (return i))))
  n)