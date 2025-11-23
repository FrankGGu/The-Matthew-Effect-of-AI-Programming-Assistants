#lang racket

(define (make-bookings n m)
  (let* ([max-seats (make-vector n m)]
         [max-seg (make-vector (* 4 n) 0)]
         [sum-seg (make-vector (* 4 n) 0)])

    (define (build u l r)
      (if (= l r)
          (begin
            (vector-set! max-seg u (vector-ref max-seats l))
            (vector-set! sum-seg u (vector-ref max-seats l)))
          (let ([mid (quotient (+ l r) 2)])
            (build (* 2 u) l mid)
            (build (+ (* 2 u) 1) (+ mid 1) r)
            (vector-set! max-seg u (max (vector-ref max-seg (* 2 u)) (vector-ref max-seg (+ (* 2 u) 1))))
            (vector-set! sum-seg u (+ (vector-ref sum-seg (* 2 u)) (vector-ref sum-seg (+ (* 2 u) 1)))))))

    (build 1 0 (- n 1))

    (define (query-max u l r ql qr)
      (if (> ql r qr l)
          -inf.0
          (if (and (<= ql l) (<= r qr))
              (vector-ref max-seg u)
              (let ([mid (quotient (+ l r) 2)])
                (max (query-max (* 2 u) l mid ql qr)
                     (query-max (+ (* 2 u) 1) (+ mid 1) r ql qr))))))

    (define (query-sum u l r ql qr)
      (if (> ql r qr l)
          0
          (if (and (<= ql l) (<= r qr))
              (vector-ref sum-seg u)
              (let ([mid (quotient (+ l r) 2)])
                (+ (query-sum (* 2 u) l mid ql qr)
                   (query-sum (+ (* 2 u) 1) (+ mid 1) r ql qr))))))

    (define (update u l r pos val)
      (if (= l r)
          (begin
            (vector-set! max-seg u val)
            (vector-set! sum-seg u val))
          (let ([mid (quotient (+ l r) 2)])
            (if (<= pos mid)
                (update (* 2 u) l mid pos val)
                (update (+ (* 2 u) 1) (+ mid 1) r pos val))
            (vector-set! max-seg u (max (vector-ref max-seg (* 2 u)) (vector-ref max-seg (+ (* 2 u) 1)))
            (vector-set! sum-seg u (+ (vector-ref sum-seg (* 2 u)) (vector-ref sum-seg (+ (* 2 u) 1)))))))

    (define (gather k max-row)
      (let loop ([low 0] [high max-row])
        (if (> low high)
            '()
            (let ([mid (quotient (+ low high) 2)])
              (if (> (query-max 1 0 (- n 1) 0 mid) k)
                  (loop low (- mid 1))
                  (loop (+ mid 1) high)))))
      (let ([row (if (null? res) -1 (car res))])
        (if (= row -1)
            '()
            (let ([seats (vector-ref max-seats row)])
              (vector-set! max-seats row (- seats k))
              (update 1 0 (- n 1) row (vector-ref max-seats row))
              (list row (- seats k))))))

    (define (scatter k max-row)
      (let ([total (query-sum 1 0 (- n 1) 0 max-row)])
        (if (< total k)
            #f
            (let loop ([i 0] [remaining k] [res '()])
              (if (or (> i max-row) (<= remaining 0))
                  (reverse res)
                  (let ([seats (vector-ref max-seats i)])
                    (if (<= seats remaining)
                        (begin
                          (vector-set! max-seats i 0)
                          (update 1 0 (- n 1) i 0)
                          (loop (+ i 1) (- remaining seats) (cons (list i 0) res)))
                        (begin
                          (vector-set! max-seats i (- seats remaining))
                          (update 1 0 (- n 1) i (vector-ref max-seats i))
                          (reverse (cons (list i (- seats remaining)) res))))))))))

    (lambda (method . args)
      (case method
        [(gather) (apply gather args)]
        [(scatter) (apply scatter args)]))))

(define (make-bookings-system n m)
  (let ([bookings (make-bookings n m)])
    (lambda (method . args)
      (apply bookings method args))))

(define (solve)
  (let* ([input (read)]
         [n (car input)]
         [m (cadr input)]
         [system (make-bookings-system n m)]
         [output '()])
    (let loop ([ops (cddr input)])
      (if (null? ops)
          (reverse output)
          (let* ([op (car ops)]
                 [method (car op)]
                 [args (cdr op)]
                 [res (apply system method args)])
            (loop (cdr ops) (cons res output))))))
  output)

(solve)