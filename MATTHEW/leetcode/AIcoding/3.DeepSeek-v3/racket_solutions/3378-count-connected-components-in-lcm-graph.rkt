#lang racket

(require math/number-theory)

(define (count-components nums)
  (define n (length nums))
  (define parent (make-vector n 0))
  (define rank (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! rank i 0)

  (define (find u)
    (if (= u (vector-ref parent u))
        u
        (let ([root (find (vector-ref parent u))])
          (vector-set! parent u root)
          root)))

  (define (union u v)
    (let ([root-u (find u)]
          [root-v (find v)])
      (unless (= root-u root-v)
        (if (> (vector-ref rank root-u) (vector-ref rank root-v))
            (vector-set! parent root-v root-u)
            (begin
              (vector-set! parent root-u root-v)
              (when (= (vector-ref rank root-u) (vector-ref rank root-v))
                (vector-set! rank root-v (+ (vector-ref rank root-v) 1))))))))

  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (when (> (gcd (list-ref nums i) (list-ref nums j)) 1)
        (union i j))))

  (define components (make-hash))
  (for ([i (in-range n)])
    (hash-set! components (find i) #t)
  (hash-count components))