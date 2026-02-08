(define (largest-prime-substring s)
  (define (string->number str)
    (string->number/locale str #f))

  (define (is-prime? n)
    (cond [(<= n 1) #f]
          [(= n 2) #t]
          [(even? n) #f]
          [else
           (let loop ([i 3])
             (cond [(> (* i i) n) #t]
                   [(= (modulo n i) 0) #f]
                   [else (loop (+ i 2))]))]))

  (define (find-largest-prime str)
    (let loop ([len (string-length str)])
      (cond [(zero? len) 0]
            [else
             (let loop2 ([start 0])
               (cond [(>= start (+ (string-length str) (- len))) 0]
                     [else
                      (let ([sub (substring str start (+ start len))])
                        (let ([num (string->number sub)])
                          (cond [(and num (is-prime? num)) num]
                                [else (loop2 (+ start 1))])))]))
             (or (find-largest-prime (substring str 0 (- (string-length str) 1)))
                 (find-largest-prime (substring str 1 (string-length str))))
             (loop (- len 1))])))

  (find-largest-prime s))

(define (solve s)
  (let loop ([i 0] [sum 0])
    (cond [(>= i (string-length s)) sum]
          [else
           (let ([sub (substring s i (string-length s))])
             (let ([prime (largest-prime-substring sub)])
               (cond [(> prime 0)
                      (loop (+ i (number->string-length prime)) (+ sum prime))]
                     [else (loop (+ i 1) sum)])))])))

(define (number->string-length n)
  (string-length (number->string n)))

(define (sum-of-largest-prime-substrings s)
  (solve s))