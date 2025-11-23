#lang racket

(define (get-biggest-three grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define sums (make-hash))

  (define (get-value i j)
    (if (and (>= i 0) (< i m) (>= j 0) (< j n))
        (list-ref (list-ref grid i) j)
        0))

  (for* ([i (in-range m)]
         [j (in-range n)]
         [k (in-range 0 (min (quotient (- m i) 2)
                             (quotient (- n j) 2)
                             (quotient i 1)
                             (quotient (- n j 1) 1)) +1 1)])
    (define sum (+ (get-value i j)
                   (get-value (+ i k) (- j k))
                   (get-value (+ i (* 2 k)) j)
                   (get-value (+ i k) (+ j k))))
    (when (> k 0)
      (for ([l (in-range 1 k)])
        (set! sum (+ sum (get-value (+ i l) (- j l))
                        (get-value (+ i (* 2 k) (- l)) (+ j l))
                        (get-value (+ i (* 2 k) (- l)) (- j l))
                        (get-value (+ i l) (+ j l))))))
    (hash-set! sums sum #t)))

  (define sorted-sums (sort (hash-keys sums) >))
  (define result (take sorted-sums (min 3 (length sorted-sums))))
  (reverse result))