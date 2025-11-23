(define (maximum-sum-of-an-hourglass grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define (get-val r c)
    (list-ref (list-ref grid r) c))

  (define max-s 0)

  (for* ([r (in-range 0 (- m 2))]
         [c (in-range 0 (- n 2))])
    (define current-sum
      (+ (get-val r c)
         (get-val r (+ c 1))
         (get-val r (+ c 2))
         (get-val (+ r 1) (+ c 1))
         (get-val (+ r 2) c)
         (get-val (+ r 2) (+ c 1))
         (get-val (+ r 2) (+ c 2))))
    (set! max-s (max max-s current-sum)))
  max-s)