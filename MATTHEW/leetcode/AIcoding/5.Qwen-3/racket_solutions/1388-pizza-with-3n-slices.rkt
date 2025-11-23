#lang racket

(define (count-pizza slices)
  (define n (quotient (length slices) 3))
  (define dp (make-vector (* 2 n) 0))
  (define (max-value i j)
    (if (>= i j)
        0
        (let ((k (quotient (+ i j) 2)))
          (max (+ (vector-ref dp i) (vector-ref dp (add1 k)))
               (+ (vector-ref dp (add1 k)) (vector-ref dp j))))))
  (define (solve i j)
    (if (>= i j)
        0
        (let ((k (quotient (+ i j) 2)))
          (let ((left (solve i (sub1 k)))
                (right (solve (add1 k) j)))
            (max (+ left right) (solve i (sub1 k)) (solve (add1 k) j))))))
  (solve 0 (sub1 (length slices))))

(define (main)
  (define input (read-line))
  (define slices (map string->number (string-split input)))
  (display (count-pizza slices)))

(main)