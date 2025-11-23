(define (max-distance positions m)
  (define (possible? dist)
    (define (count-balls start)
      (cond
        [(>= start (length positions)) 0]
        [else
         (let loop ([i start] [count 1])
           (if (>= i (length positions))
               count
               (let ([next (findf (lambda (j) (>= (- (list-ref positions j) (list-ref positions i)) dist))
                                  (range (+ i 1) (length positions)))])
                 (if next
                     (loop next (+ count 1))
                     count))))]))
    (>= (count-balls 0) m))

  (let* ([sorted-positions (sort positions <)]
         [low 1]
         [high (- (last sorted-positions) (first sorted-positions))])
    (let loop ([l low] [r high])
      (if (>= l r)
          (if (possible? r) r l)
          (let ([mid (floor (+ l r) 2)])
            (if (possible? mid)
                (loop (+ mid 1) r)
                (loop l (- mid 1))))))))