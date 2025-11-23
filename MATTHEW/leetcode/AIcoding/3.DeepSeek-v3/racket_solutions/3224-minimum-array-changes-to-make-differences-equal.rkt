(define (min-operations nums)
  (define n (length nums))
  (if (<= n 1)
      0
      (let* ([diff (for/list ([i (in-range 1 n)])
                     (- (list-ref nums i) (list-ref nums (- i 1))))]
             [max-diff (apply max diff)]
             [min-diff (apply min diff)])
        (if (= max-diff min-diff)
            0
            (let ([target1 (quotient (+ max-diff min-diff) 2)]
                  [target2 (quotient (+ max-diff min-diff 1) 2)])
              (min (count-operations nums target1)
                   (count-operations nums target2)))))))

(define (count-operations nums target)
  (define n (length nums))
  (define operations 0)
  (define prev (car nums))
  (for ([i (in-range 1 n)])
    (define current (list-ref nums i))
    (define desired (- prev target))
    (set! operations (+ operations (abs (- current desired))))
    (set! prev desired))
  operations)