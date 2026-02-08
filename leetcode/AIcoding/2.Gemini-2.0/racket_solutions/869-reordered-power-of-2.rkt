(define (reordered-power-of2 n)
  (define (digits x)
    (let loop ([x x] [acc '()])
      (if (zero? x)
          acc
          (loop (quotient x 10) (cons (remainder x 10) acc)))))

  (define (is-power-of-two? x)
    (and (> x 0) (zero? (bitwise-and x (- x 1)))))

  (define (permutations lst)
    (if (null? lst)
        '(())
        (foldr
         (lambda (x acc)
           (apply append
                  (map (lambda (p)
                         (let loop ([lst lst] [i 0] [result '()])
                           (if (= i (length lst))
                               (cons x p)
                               (if (equal? (list-ref lst i) x)
                                   (loop lst (+ i 1) result)
                                   (loop lst (+ i 1) (cons (list-ref lst i) result))))))
                       acc)))
         '((())) lst)))

  (define (list->integer lst)
    (foldl (lambda (digit acc) (+ (* acc 10) digit)) 0 lst))

  (let ([ds (digits n)])
    (ormap (lambda (p)
             (let ([num (list->integer p)])
               (and (not (and (> (length p) 1) (zero? (car p))))
                    (is-power-of-two? num))))
           (permutations ds))))