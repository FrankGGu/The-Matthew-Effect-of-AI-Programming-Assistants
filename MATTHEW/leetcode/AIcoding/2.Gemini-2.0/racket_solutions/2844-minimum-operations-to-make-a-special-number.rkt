(define (minimum-operations s)
  (let* ([n (string-length s)]
         [count-zero (count (lambda (c) (equal? c #\0)) (string->list s))]
         [count-five (count (lambda (c) (equal? c #\5)) (string->list s))])
    (cond
      [(zero? count-zero) (if (equal? n 1) 1 n)]
      [(and (zero? count-five) (zero? count-zero)) n]
      [else
       (let loop ([i (- n 1)] [five-found? #f] [zero-found? #f] [ops 0])
         (cond
           [(< i 0) (if (and five-found? zero-found?) ops n)]
           [else
            (let ([c (string-ref s i)])
              (cond
                [(and (equal? c #\0) five-found?) (+ ops (- i 0))]
                [(and (equal? c #\0) (not five-found?)) (loop (- i 1) five-found? #t (+ ops 1))]
                [(and (equal? c #\5) zero-found?) (+ ops (- i 0))]
                [(and (equal? c #\5) (not zero-found?)) (loop (- i 1) #t zero-found? (+ ops 1))]
                [(equal? c #\2) (loop (- i 1) five-found? zero-found? (+ ops 1))]
                [(equal? c #\7) (loop (- i 1) five-found? zero-found? (+ ops 1))]
                [(equal? c #\5) (loop (- i 1) #t zero-found? (+ ops 1))]
                [(equal? c #\0) (loop (- i 1) five-found? #t (+ ops 1))]
                [else (loop (- i 1) five-found? zero-found? (+ ops 1))]))]))]))))