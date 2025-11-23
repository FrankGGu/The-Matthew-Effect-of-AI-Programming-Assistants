(define (probability-of-a-two-boxes-having-the-same-number-of-distinct-balls balls)
  (define n (length balls))
  (define total-balls (apply + balls))
  (define half-balls (/ total-balls 2))

  (define (combinations n k)
    (if (or (< k 0) (> k n))
        0
        (if (or (= k 0) (= k n))
            1
            (if (< k (/ n 2))
                (let loop ([i 1] [res 1])
                  (if (> i k)
                      res
                      (loop (+ i 1) (/ (* res (- n (+ i -1))) i))))
                (combinations n (- n k))))))

  (define (multinomial coefficients counts)
    (define total (apply + counts))
    (let loop ([i 0] [res 1])
      (if (= i (length coefficients))
          res
          (loop (+ i 1) (/ (* res (list-ref coefficients i)) (combinations (- total (apply + (take counts i))) (list-ref counts i)))))))

  (define total-ways (multinomial (map factorial balls) balls))

  (define good-ways
    (let loop ([i 0] [current-balls-in-box1 (make-vector n 0)])
      (if (= i n)
          (if (= (apply + (vector->list current-balls-in-box1)) half-balls)
              (if (= (length (remove-duplicates (filter (lambda (x) (> x 0)) (vector->list current-balls-in-box1))))
                     (/ n 2))
                  (let ([balls-in-box2 (map - balls (vector->list current-balls-in-box1))])
                    (if (= (length (remove-duplicates (filter (lambda (x) (> x 0)) balls-in-box2)))
                       (/ n 2))
                      (* (multinomial (map factorial (vector->list current-balls-in-box1)) (vector->list current-balls-in-box1))
                         (multinomial (map factorial balls-in-box2) balls-in-box2))
                      0))
                  0)
              0)
          (let ([max-balls (list-ref balls i)])
            (let inner-loop ([j 0] [sum 0])
              (if (> j max-balls)
                  sum
                  (begin
                    (vector-set! current-balls-in-box1 i j)
                    (inner-loop (+ j 1) (+ sum (loop (+ i 1) current-balls-in-box1)))))))))))

  (/ good-ways total-ways))