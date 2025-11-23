(define (count-beautiful-splits nums)
  (define n (length nums))
  (define left-sum (make-vector n 0))
  (define right-sum (make-vector n 0))

  (vector-set! left-sum 0 (vector-ref nums 0))
  (for ((i (in-range 1 n)))
    (vector-set! left-sum i (+ (vector-ref left-sum (- i 1)) (vector-ref nums i))))

  (vector-set! right-sum (- n 1) (vector-ref nums (- n 1)))
  (for ((i (in-range (- n 2) -1 -1)))
    (vector-set! right-sum i (+ (vector-ref right-sum (+ i 1)) (vector-ref nums i))))

  (define count 0)
  (for ((i (in-range (- n 1))))
    (when (= (vector-ref left-sum i) (vector-ref right-sum (+ i 1)))
      (set! count (+ count 1))))

  count)

(define (beautifulSplits nums)
  (count-beautiful-splits nums))