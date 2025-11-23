(define (digit-count n)
  (let loop ([n n] [counts (make-vector 10 0)])
    (if (= n 0)
        counts
        (let ([digit (modulo n 10)])
          (vector-set! counts digit (+ 1 (vector-ref counts digit)))
          (loop (quotient n 10) counts)))))

(define (numerically-balanced? n)
  (let ([counts (digit-count n)])
    (let loop ([i 0])
      (cond
        [(>= i 10) #t]
        [(= (vector-ref counts i) 0) (loop (+ i 1))]
        [(= (vector-ref counts i) i) (loop (+ i 1))]
        [else #f]))))

(define (next-greater-numerically-balanced-number n)
  (let loop ([i (+ n 1)])
    (if (numerically-balanced? i)
        i
        (loop (+ i 1)))))