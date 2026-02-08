#lang racket

(define (ways pizza k)
  (define rows (length pizza))
  (define cols (if (null? pizza) 0 (string-length (car pizza))))

  (define (has-apple? r1 c1 r2 c2)
    (for/or ([i (in-range r1 r2)])
      (for/or ([j (in-range c1 c2)])
        (char=? (string-ref (list-ref pizza i) j) #\A)))))

  (define memo (make-hash))

  (define (dp r c k)
    (define key (list r c k))
    (if (hash-has-key? memo key)
        (hash-ref memo key)
        (let ()
          (if (zero? k)
              (if (has-apple? r c rows cols) 1 0)
              (let ([res 0])
                (for ([i (in-range r rows)])
                  (when (has-apple? r c (add1 i) cols)
                    (set! res (+ res (dp (add1 i) c (sub1 k))))))
                (for ([j (in-range c cols)])
                  (when (has-apple? r c rows (add1 j))
                    (set! res (+ res (dp r (add1 j) (sub1 k))))))
                (hash-set! memo key (modulo res 1000000007))
                (hash-ref memo key)))))))

  (dp 0 0 (sub1 k)))