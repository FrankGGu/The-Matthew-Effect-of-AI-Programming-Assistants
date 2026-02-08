(define (nth-ugly-number n a b c)
  (define (count-less-than x a b c)
    (+ (quotient x a) (quotient x b) (quotient x c)
       (- (quotient x (lcm a b)))
       (- (quotient x (lcm a c)))
       (- (quotient x (lcm b c)))
       (+ (quotient x (lcm a (lcm b c))))))

  (define (binary-search low high)
    (if (> low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (>= (count-less-than mid a b c) n)
              (binary-search low (- mid 1))
              (binary-search (+ mid 1) high)))))

  (binary-search 1 (* 2 (max a b c) n)))