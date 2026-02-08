(define (beautiful-integers low high k)
  (define (is-beautiful n)
    (and (not (= n 0))
         (= (modulo n k) 0)))
  (define (count-beautiful low high)
    (if (> low high)
        0
        (+ (if (is-beautiful low) 1 0)
           (count-beautiful (add1 low) high))))
  (count-beautiful low high))

(define (countBeautifulIntegers low high k)
  (beautiful-integers low high k))