(define (search-matrix matrix target)
  (define (rows matrix) (length matrix))
  (define (cols matrix) (length (first matrix)))

  (define (binary-search-row row target)
    (define (helper low high)
      (cond
        [(> low high) #f]
        [else
         (let* ([mid (floor (+ low high) 2)]
                [mid-val (list-ref row mid)])
           (cond
             [(= mid-val target) #t]
             [(< mid-val target) (helper (+ mid 1) high)]
             [else (helper low (- mid 1))]))]))
    (helper 0 (- (cols matrix) 1)))

  (define (find-row target)
    (define (helper low high)
      (cond
        [(> low high) #f]
        [else
         (let* ([mid (floor (+ low high) 2)]
                [first-in-row (list-ref (list-ref matrix mid) 0)]
                [last-in-row (list-ref (list-ref matrix mid) (- (cols matrix) 1))])
           (cond
             [(and (<= first-in-row target) (>= last-in-row target))
              (list-ref matrix mid)]
             [(< last-in-row target) (helper (+ mid 1) high)]
             [else (helper low (- mid 1))]))]))
    (helper 0 (- (rows matrix) 1)))

  (let ([row (find-row target)])
    (if row
        (binary-search-row row target)
        #f)))