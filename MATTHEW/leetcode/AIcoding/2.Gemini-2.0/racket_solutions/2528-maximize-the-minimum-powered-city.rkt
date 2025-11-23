(define (max-power stations power k)
  (define n (length stations))
  (define (check-power p)
    (define acc (make-vector n 0))
    (define curr 0)
    (for/list ([i (in-range n)])
      (begin
        (set! curr (+ curr (vector-ref acc i)))
        (if (< (+ (list-ref stations i) curr) p)
            (let ([diff (- p (+ (list-ref stations i) curr))])
              (if (> diff k)
                  #f
                  (begin
                    (set! k (- k diff))
                    (set! curr (+ curr diff))
                    (if (< (+ i power) n)
                        (vector-set! acc (+ i power) (- (vector-ref acc (+ i power)) diff)))
                    (if (>= (- i power) 0)
                        (vector-set! acc (- i power) (+ (vector-ref acc (- i power)) diff)))
                    diff)))))
        #t))
    #t)

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (check-power mid)
              (binary-search (+ mid 1) high)
              (binary-search low mid)))))

  (binary-search 0 (+ (apply max stations) k)))