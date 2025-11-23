(define (longest-obstacle-course-at-each-position obstacles)
  (define n (length obstacles))
  (define tail (make-vector n #inf.0))
  (define lengths (make-vector n 0))
  (define (binary-search target)
    (let loop ([low 0] [high (vector-length tail)])
      (cond
        [(>= low high) low]
        [else
         (let ([mid (floor (+ low high) 2)])
           (if (<= (vector-ref tail mid) target)
               (loop (+ mid 1) high)
               (loop low mid)))])))
  (let loop ([i 0] [length 0])
    (if (= i n)
        (vector->list lengths)
        (let* ([obstacle (vector-ref obstacles i)]
               [pos (binary-search obstacle)])
          (vector-set! tail pos obstacle)
          (vector-set! lengths i (+ pos 1))
          (loop (+ i 1) (max length (+ pos 1))))))
  )