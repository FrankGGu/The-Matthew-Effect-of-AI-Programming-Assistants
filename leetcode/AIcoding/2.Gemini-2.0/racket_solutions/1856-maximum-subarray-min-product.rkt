(define (max-subarray-min-product nums)
  (define n (length nums))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for/fold ([i 0]
             [sum 0])
            ([num (in-list nums)])
    (vector-set! prefix-sum (+ i 1) (+ sum num))
    (values (+ i 1) (+ sum num)))

  (define (get-sum l r)
    (- (vector-ref prefix-sum (+ r 1))
       (vector-ref prefix-sum l)))

  (define (solve)
    (define left (make-vector n 0))
    (define right (make-vector n 0))
    (define stack '())

    (for ([i (in-range n)])
      (while (and (not (null? stack))
                  (>= (list-ref nums i) (list-ref nums (car stack))))
        (set! stack (cdr stack)))
      (vector-set! left i (if (null? stack) 0 (+ (car stack) 1)))
      (set! stack (cons i stack)))

    (set! stack '())
    (for ([i (in-range (- n 1) -1 -1)])
      (while (and (not (null? stack))
                  (> (list-ref nums i) (list-ref nums (car stack))))
        (set! stack (cdr stack)))
      (vector-set! right i (if (null? stack) (- n 1) (- (car stack) 1)))
      (set! stack (cons i stack)))

    (for/fold ([max-product 0])
              ([i (in-range n)])
      (let* ([l (vector-ref left i)]
             [r (vector-ref right i)]
             [min-val (list-ref nums i)]
             [sum (get-sum l r)]
             [product (modulo (* min-val sum) 1000000007)])
        (max max-product product))))

  (solve))