#lang racket

(define (nth-ugly-number n)
  (cond
    ((<= n 0) 0)
    ((= n 1) 1)
    (else
     (let* ([dp (make-vector n 0)]
            [p2 0]
            [p3 0]
            [p5 0])
       (vector-set! dp 0 1)
       (for ([i (in-range 1 n)])
         (let* ([val2 (* (vector-ref dp p2) 2)]
                [val3 (* (vector-ref dp p3) 3)]
                [val5 (* (vector-ref dp p5) 5)]
                [min-val (min val2 val3 val5)])
           (vector-set! dp i min-val)
           (when (= min-val val2)
             (set! p2 (+ p2 1)))
           (when (= min-val val3)
             (set! p3 (+ p3 1)))
           (when (= min-val val5)
             (set! p5 (+ p5 1)))))
       (vector-ref dp (- n 1))))))