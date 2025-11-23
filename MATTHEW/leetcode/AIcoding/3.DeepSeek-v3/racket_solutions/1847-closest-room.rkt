(define (closest-rooms rooms queries)
  (define (sort-rooms)
    (sort rooms (lambda (a b) (< (car a) (car b)))))
  (define sorted-rooms (sort-rooms))
  (define (binary-search target)
    (let loop ([low 0] [high (sub1 (length sorted-rooms))])
      (if (> low high)
          high
          (let ([mid (quotient (+ low high) 2)])
            (if (<= (car (list-ref sorted-rooms mid)) target)
                (loop (add1 mid) high)
                (loop low (sub1 mid)))))))
  (define (find-closest-room pos size)
    (let ([candidate1 (if (>= pos 0) (list-ref sorted-rooms pos) null)]
          [candidate2 (if (< (add1 pos) (length sorted-rooms)) (list-ref sorted-rooms (add1 pos)) null)])
      (cond [(and (null? candidate1) (null? candidate2)) -1]
            [(null? candidate1) (if (>= (cadr candidate2) size) (car candidate2) -1)]
            [(null? candidate2) (if (>= (cadr candidate1) size) (car candidate1) -1)]
            [else (let ([size1 (>= (cadr candidate1) size)]
                    (let ([size2 (>= (cadr candidate2) size)])
                      (cond [(and size1 size2)
                             (if (<= (abs (- (car candidate1) pos))
                                     (abs (- (car candidate2) pos)))
                                 (car candidate1)
                                 (car candidate2))]
                            [size1 (car candidate1)]
                            [size2 (car candidate2)]
                            [else -1])))]))))
  (map (lambda (query)
         (let ([pos (binary-search (car query))])
           (find-closest-room pos (cadr query))))
       queries))