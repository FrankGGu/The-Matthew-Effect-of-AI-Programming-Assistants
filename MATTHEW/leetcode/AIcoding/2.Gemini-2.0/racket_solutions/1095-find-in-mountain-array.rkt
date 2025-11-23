(define (find-in-mountain-array target mountain-arr)
  (define (get index)
    (send mountain-arr get index))
  (define (length)
    (send mountain-arr length))

  (define (find-peak)
    (let loop ([low 0] [high (- (length) 1)])
      (cond
        [(= low high) low]
        [else
         (let ([mid (floor (/ (+ low high) 2))])
           (if (> (get mid) (get (+ mid 1)))
               (loop low mid)
               (loop (+ mid 1) high)))])))

  (define (binary-search-ascending low high)
    (cond
      [(>= low high)
       (cond
         [(= (get low) target) low]
         [else -1])]
      [else
       (let ([mid (floor (/ (+ low high) 2))])
         (cond
           [(< (get mid) target) (binary-search-ascending (+ mid 1) high)]
           [(> (get mid) target) (binary-search-ascending low (- mid 1))]
           [else mid]))]))

  (define (binary-search-descending low high)
    (cond
      [(>= low high)
       (cond
         [(= (get low) target) low]
         [else -1])]
      [else
       (let ([mid (floor (/ (+ low high) 2))])
         (cond
           [(< (get mid) target) (binary-search-descending low (- mid 1))]
           [(> (get mid) target) (binary-search-descending (+ mid 1) high)]
           [else mid]))]))

  (let ([peak (find-peak)])
    (let ([ascending-result (binary-search-ascending 0 peak)])
      (if (not (= ascending-result -1))
          ascending-result
          (binary-search-descending (+ peak 1) (- (length) 1))))))