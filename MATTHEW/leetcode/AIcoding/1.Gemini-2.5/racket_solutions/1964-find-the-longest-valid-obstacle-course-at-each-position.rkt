(define (find-upper-bound v len target)
  (let loop ([low 0] [high len])
    (if (= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (> (vector-ref v mid) target)
              (loop low mid)
              (loop (+ mid 1) high))))))

(define (longest-obstacle-course obstacles)
  (let* ([n (length obstacles)]
         [result (make-vector n)]
         [tails (make-vector n 0)]
         [tails-len 0])
    (for ([i (in-range n)])
      (let* ([x (list-ref obstacles i)]
             [j (find-upper-bound tails tails-len x)])
        (if (= j tails-len)
            (begin
              (vector-set! tails tails-len x)
              (set! tails-len (+ tails-len 1)))
            (vector-set! tails j x))
        (vector-set! result i (+ j 1))))
    (vector->list result)))