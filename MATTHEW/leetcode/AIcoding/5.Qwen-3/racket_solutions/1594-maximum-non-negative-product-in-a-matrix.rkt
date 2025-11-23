#lang racket

(define (max-non-negative-product matrix)
  (define rows (length matrix))
  (define cols (length (car matrix)))
  (define dp (make-vector rows (make-vector cols (vector 0 0))))
  (define (get i j)
    (vector-ref (vector-ref dp i) j))
  (define (set i j val)
    (vector-set! (vector-ref dp i) j val))
  (set 0 0 (vector (list-ref (list-ref matrix 0) 0) (list-ref (list-ref matrix 0) 0)))
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (and (= i 0) (= j 0)) #f)
      (when (= i 0)
        (set i j (vector (* (list-ref (list-ref matrix i) j) (vector-ref (get i (- j 1)) 0)) (vector-ref (get i (- j 1)) 1))))
      (when (= j 0)
        (set i j (vector (* (list-ref (list-ref matrix i) j) (vector-ref (get (- i 1) j) 0)) (vector-ref (get (- i 1) j) 1))))
      (when (and (> i 0) (> j 0))
        (let* ([up (get (- i 1) j)]
               [left (get i (- j 1))]
               [max-val (max (vector-ref up 0) (vector-ref left 0))]
               [min-val (min (vector-ref up 1) (vector-ref left 1))])
          (set i j (vector (* (list-ref (list-ref matrix i) j) max-val) (* (list-ref (list-ref matrix i) j) min-val)))))))
  (define (max-val i j)
    (if (>= i rows) -inf.0 (if (>= j cols) -inf.0 (vector-ref (get i j) 0))))
  (define (max-path i j)
    (cond [(or (>= i rows) (>= j cols)) -inf.0]
          [(and (= i (- rows 1)) (= j (- cols 1))) (vector-ref (get i j) 0)]
          [else
           (let* ([up (if (>= (+ i 1) rows) -inf.0 (max-path (+ i 1) j))]
                  [right (if (>= (+ j 1) cols) -inf.0 (max-path i (+ j 1)))]
                  [current (vector-ref (get i j) 0)])
             (max current up right))]))
  (max-path 0 0))