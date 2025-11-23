(define (number-of-beautiful-integers n k)
  (define (digit-vector n)
    (let loop ((n n) (acc '()))
      (if (zero? n)
          (if (null? acc) '(0) (reverse acc))
          (loop (quotient n 10) (cons (remainder n 10) acc)))))

  (define (count-beautiful-up-to n k)
    (define digits (digit-vector n))
    (define len (length digits))

    (define (dp idx even-count tight)
      (cond
        [(zero? idx) (if (zero? (modulo even-count k)) 1 0)]
        [else
         (define upper-bound (if tight (list-ref digits (- len idx)) 9))
         (let loop ((digit 0) (acc 0))
           (if (> digit upper-bound)
               acc
               (let* ((new-even-count (if (even? digit) (+ even-count 1) even-count))
                      (new-tight (and tight (= digit upper-bound))))
                 (loop (+ digit 1) (+ acc (memoized-dp (- idx 1) new-even-count new-tight))))))]))

    (define memoized-dp
      (memoize
       (lambda (idx even-count tight)
         (dp idx even-count tight))))

    (dp len 0 #t))

  (- (count-beautiful-up-to n k) (count-beautiful-up-to (- n 1) k)))