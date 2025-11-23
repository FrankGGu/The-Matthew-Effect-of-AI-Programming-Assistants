(define (distinct-difference-array nums)
  (define n (length nums))
  (define prefix (make-vector n 0))
  (define suffix (make-vector n 0))

  (define (count-distinct lst)
    (length (remove-duplicates lst)))

  (for ([i (in-range n)])
    (vector-set! prefix i (count-distinct (take nums (+ i 1)))))

  (for ([i (in-range n)])
    (vector-set! suffix i (count-distinct (drop nums i))))

  (define result (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! result i (- (vector-ref prefix i) (vector-ref suffix i))))

  (vector->list result))