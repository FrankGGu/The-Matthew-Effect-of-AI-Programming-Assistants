#lang racket

(define (minimum-removals-to-make-mountain-array nums)
  (let* ([n (vector-length nums)]
         [dp-inc (make-vector n 1)]
         [dp-dec (make-vector n 1)])

    (for ([i (in-range n)])
      (for ([j (in-range i)])
        (when (> (vector-ref nums i) (vector-ref nums j))
          (vector-set! dp-inc i (max (vector-ref dp-inc i) (+ (vector-ref dp-inc j) 1))))))

    (for ([i (in-range (- n 1) -1 -1)])
      (for ([j (in-range (- n 1) i -1)])
        (when (> (vector-ref nums i) (vector-ref nums j))
          (vector-set! dp-dec i (max (vector-ref dp-dec i) (+ (vector-ref dp-dec j) 1))))))

    (let ([max-mountain-len 0])
      (for ([i (in-range n)])
        (when (and (> (vector-ref dp-inc i) 1)
                   (> (vector-ref dp-dec i) 1))
          (set! max-mountain-len (max max-mountain-len (+ (vector-ref dp-inc i) (vector-ref dp-dec i) -1)))))

      (- n max-mountain-len))))