(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (loop2 (+ j 1))]
           [else (loop2 (+ j 1))]))]))

(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (loop2 (+ j 1))]
           [else (loop2 (+ j 1))]))]))

(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (loop2 (+ j 1))]
           [else (loop2 (+ j 1))]))]))

(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (cons (~a j "/" i) (loop2 (+ j 1)))]
           [else (loop2 (+ j 1))]))]))

(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (loop2 (+ j 1))]
           [else (loop2 (+ j 1))]))])
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (let loop2 ([j 1])
         (cond
           [(>= j i) (loop (+ i 1) result)]
           [(= (gcd i j) 1) (cons (~a j "/" i) (loop2 (+ j 1)))]
           [else (loop2 (+ j 1))]))])))
(define (simplified-fractions n)
  (let loop ([i 2] [result '()])
    (cond
      [(> i n) result]
      [else
       (append
        (let loop2 ([j 1] [res '()])
          (cond
            [(>= j i) res]
            [(= (gcd i j) 1) (loop2 (+ j 1) (cons (~a j "/" i) res))]
            [else (loop2 (+ j 1) res)]))
        (loop (+ i 1) result))])))