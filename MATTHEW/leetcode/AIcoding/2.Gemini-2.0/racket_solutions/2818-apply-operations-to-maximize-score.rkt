(define (isPrime? n)
  (cond
    [(<= n 1) #f]
    [(<= n 3) #t]
    [(or (zero? (modulo n 2)) (zero? (modulo n 3))) #f]
    [else
     (let loop ([i 5])
       (cond
         [(> (* i i) n) #t]
         [(or (zero? (modulo n i)) (zero? (modulo n (+ i 2)))) #f]
         [else (loop (+ i 6))]))]))

(define (greatest-prime-factor n)
  (let loop ([i 2] [num n] [max-prime 1])
    (cond
      [(> i (sqrt num))
       (if (> num 1) num max-prime)]
      [(zero? (modulo num i))
       (loop i (/ num i) i)]
      [else (loop (+ i 1) num max-prime)])))

(define (max-score nums p k)
  (let ([n (length nums)])
    (let ([factors (make-vector n)])
      (for/list ([i (in-range n)])
        (vector-set! factors i (greatest-prime-factor (list-ref nums i))))
      (let ([indices (range 0 n)])
        (define sorted-indices
          (sort indices
                (lambda (i1 i2) (> (vector-ref factors i1) (vector-ref factors i2)))))
        (foldl (lambda (i acc)
                 (modulo (* acc (vector-ref factors i)) 1000000007))
               1
               (take sorted-indices k))))))