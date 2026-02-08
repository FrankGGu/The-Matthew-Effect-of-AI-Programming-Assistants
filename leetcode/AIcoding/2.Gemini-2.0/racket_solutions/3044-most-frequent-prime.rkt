(define (most-frequent-prime mat)
  (define (is-prime? n)
    (cond
      [(<= n 1) #f]
      [(= n 2) #t]
      [(even? n) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) n) #t]
           [(zero? (remainder n i)) #f]
           [else (loop (+ i 2))]))]))

  (define (get-nums mat)
    (let* ([rows (length mat)]
           [cols (length (car mat))])
      (let loop ([nums '()] [r 0] [c 0])
        (cond
          [(>= r rows) nums]
          [else
           (let ([num (list-ref (list-ref mat r) c)])
             (loop (cons num nums) r (if (< (+ c 1) cols) (+ c 1) 0) (if (< (+ c 1) cols) r (+ r 1))))]))))

  (define (count-occurrences lst)
    (let loop ([lst lst] [counts '()])
      (cond
        [(null? lst) counts]
        [else
         (let ([x (car lst)])
           (let ([existing (assoc x counts)])
             (if existing
                 (loop (cdr lst) (cons (cons x (+ 1 (cdr existing))) (remove existing counts)))
                 (loop (cdr lst) (cons (cons x 1) counts)))))])))

  (define (find-most-frequent-prime mat)
    (let* ([rows (length mat)]
           [cols (length (car mat))]
           [nums '()])

      (define (extract-numbers r c dr dc)
        (let loop ([r r] [c c] [num 0] [nums '()])
          (cond
            [(or (< r 0) (>= r rows) (< c 0) (>= c cols)) nums]
            [else
             (let ([new-num (+ (* num 10) (list-ref (list-ref mat r) c))])
               (loop (+ r dr) (+ c dc) new-num (cons new-num nums)))])))

      (define (all-nums)
        (let ([nums '()])
          (for ([r (in-range rows)])
            (for ([c (in-range cols)])
              (set! nums (append nums (extract-numbers r c 0 1)))
              (set! nums (append nums (extract-numbers r c 1 0)))
              (set! nums (append nums (extract-numbers r c 1 1)))
              (set! nums (append nums (extract-numbers r c 1 -1)))))
          nums))

      (let* ([all-possible-nums (all-nums)]
             [prime-nums (filter is-prime? (remove-duplicates all-possible-nums))]
             [counts (count-occurrences prime-nums)])

        (cond
          [(null? counts) -1]
          [else
           (let ([max-count (apply max (map cdr counts))])
             (if (zero? max-count)
                 -1
                 (let ([most-frequent-primes (filter (lambda (x) (= (cdr x) max-count)) counts)])
                   (if (null? most-frequent-primes)
                       -1
                       (apply min (map car most-frequent-primes))))))]))))

  (find-most-frequent-prime mat))