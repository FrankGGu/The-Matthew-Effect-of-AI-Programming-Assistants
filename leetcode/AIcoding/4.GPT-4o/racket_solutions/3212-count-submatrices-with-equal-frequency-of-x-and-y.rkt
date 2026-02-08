(define (count-submatrices-equal-freq mat x y)
  (define n (length mat))
  (define m (length (first mat)))
  (define (count-freq submat)
    (define x-count 0)
    (define y-count 0)
    (for ([i (in-range (length submat))])
      (for ([j (in-range (length (first submat)))])
        (cond
          [(= (list-ref (list-ref submat i) j) x) (set! x-count (+ x-count 1))]
          [(= (list-ref (list-ref submat i) j) y) (set! y-count (+ y-count 1))])))
    (if (= x-count y-count) 1 0))

  (define count 0)
  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (for ([h (in-range i n)])
        (for ([k (in-range j m)])
          (define submat (map (lambda (row) (sublist row j (add1 k))) (sublist mat i (add1 h))))
          (set! count (+ count (count-freq submat)))))))
  count)

(count-submatrices-equal-freq '((1 2 1) (2 2 1) (1 2 1)) 1 2)