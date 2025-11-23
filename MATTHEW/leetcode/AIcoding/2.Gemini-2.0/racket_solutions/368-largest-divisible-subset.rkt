(define (largest-divisible-subset nums)
  (define (sort-list lst)
    (sort lst <))

  (define (find-subset sorted-nums)
    (let* ([n (length sorted-nums)]
           [dp (make-vector n '())])
      (for ([i (in-range n)])
        (let loop ([j (in-range i -1 -1)]
                   [max-subset '()])
          (cond
            [(< j 0)
             (vector-set! dp i (list (list (list-ref sorted-nums i))))]
            [(zero? (modulo (list-ref sorted-nums i) (list-ref sorted-nums j)))
             (let ([subset (vector-ref dp j)])
               (if (> (length subset) (length max-subset))
                   (loop j-1 subset)
                   (loop j-1 max-subset)))
            ]
            [else
             (loop j-1 max-subset)])))
      (for ([i (in-range n)])
         (let ([subset (vector-ref dp i)])
              (vector-set! dp i (cons (list-ref sorted-nums i) subset))))

      (let loop ([i (in-range n)]
                 [max-subset '()])
        (cond
          [(= i n) max-subset]
          [(> (length (vector-ref dp i)) (length max-subset))
           (loop (+ i 1) (vector-ref dp i))]
          [else
           (loop (+ i 1) max-subset)]))))

  (if (null? nums)
      '()
      (find-subset (sort-list nums))))