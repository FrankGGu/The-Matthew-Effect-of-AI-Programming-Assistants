#lang racket

(define (maximum-number-that-sum-of-the-prices-is-less-than-or-equal-to-k prices k)
  (define n (length prices))

  (when (zero? n)
    0)

  (define sorted-prices (sort prices <))

  (define prefix-sums (make-vector (+ n 1) 0))
  (for ((i (in-range n)))
    (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (list-ref sorted-prices i))))

  (define (find-upper-bound-index x)
    (let loop ((low 0) (high (- n 1)) (ans -1))
      (if (> low high)
          ans
          (let* ((mid (+ low (quotient (- high low) 2))))
            (if (<= (list-ref sorted-prices mid) x)
                (loop (+ mid 1) high mid)
                (loop low (- mid 1) ans))))))

  (define (check x)
    (define idx (find-upper-bound-index x))
    (if (= idx -1)
        (<= 0 k)
        (<= (vector-ref prefix-sums (+ idx 1)) k)))

  (define low 0)
  (define high (car (last sorted-prices)))
  (define ans 0)

  (let loop ((l low) (h high) (current-ans ans))
    (if (> l h)
        current-ans
        (let* ((mid (+ l (quotient (- h l) 2))))
          (if (check mid)
              (loop (+ mid 1) h mid)
              (loop l (- mid 1) current-ans))))))