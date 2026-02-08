(define (make-array-empty nums)
  (define n (length nums))
  (define idxs (range n))
  (define sorted-idxs (sort idxs (lambda (i j) (< (list-ref nums i) (list-ref nums j)))))

  (define (count-smaller-right idxs i)
    (length (filter (lambda (j) (and (< j i) (> (list-ref nums j) (list-ref nums i)))) idxs)))

  (define (update bit idx val)
    (define (update-aux bit idx val)
      (if (<= idx n)
          (begin
            (vector-set! bit idx (+ (vector-ref bit idx) val))
            (update-aux bit (+ idx (bitwise-and idx (- idx))) val))))
    (update-aux bit (+ idx 1) val))

  (define (query bit idx)
    (define (query-aux bit idx sum)
      (if (> idx 0)
          (query-aux bit (- idx (bitwise-and idx (- idx))) (+ sum (vector-ref bit idx)))
          sum))
    (query-aux bit (+ idx 1) 0))

  (define bit (make-vector (+ n 1) 0))
  (define result 0)

  (for ([i (in-list sorted-idxs)])
    (define smaller-right (query bit n))
    (define smaller-left (query bit i))
    (set! result (+ result (- smaller-right smaller-left) 1))
    (update bit i 1))

  result)