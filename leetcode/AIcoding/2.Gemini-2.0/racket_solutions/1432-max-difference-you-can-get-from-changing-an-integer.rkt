(define (maxDiff n)
  (define (digits n)
    (if (= n 0)
        '()
        (cons (modulo n 10) (digits (quotient n 10)))))

  (define (num-from-digits ds)
    (foldl (lambda (d acc) (+ (* acc 10) d)) 0 (reverse ds)))

  (define (find-max-num ds)
    (let loop ([ds ds] [max-num (num-from-digits ds)])
      (cond
        [(null? ds) max-num]
        [else
         (let ([d (car ds)])
           (cond
             [(= d 9) (loop (cdr ds) max-num)]
             [else
              (let ([new-ds (map (lambda (x) (if (= x d) 9 x)) ds)])
                (loop (cdr ds) (max max-num (num-from-digits new-ds))))]))])))

  (define (find-min-num ds)
    (let loop ([ds ds] [min-num (num-from-digits ds)])
      (cond
        [(null? ds) min-num]
        [else
         (let ([d (car ds)] [first-digit (car (reverse ds))])
           (cond
             [(= (length ds) (length (filter (lambda (x) (= x 0)) (reverse ds)))) 0]
             [(and (= first-digit 1) (= d 0)) (loop (cdr ds) min-num)]
             [(and (= first-digit 1) (> d 0))
              (let ([new-ds (map (lambda (x) (if (= x d) 0 x)) ds)])
                (loop (cdr ds) (min min-num (num-from-digits new-ds))))]
             [(= first-digit 1) (loop (cdr ds) min-num)]
             [(> first-digit 1)
              (let ([new-ds (map (lambda (x) (if (= x d) 1 x)) ds)])
                (loop (cdr ds) (min min-num (num-from-digits new-ds))))]))])))

  (let ([ds (digits n)])
    (- (find-max-num ds) (find-min-num ds))))