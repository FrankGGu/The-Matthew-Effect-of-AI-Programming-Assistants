#lang racket

(define (count-good-triplets arr a b c)
  (let ((n (length arr)))
    (for/sum ([i (in-range 0 n)])
      (for/sum ([j (in-range (+ i 1) n)])
        (for/sum ([k (in-range (+ j 1) n)])
          (let* ((val-i (list-ref arr i))
                 (val-j (list-ref arr j))
                 (val-k (list-ref arr k)))
            (if (and (<= (abs (- val-i val-j)) a)
                     (<= (abs (- val-j val-k)) b)
                     (<= (abs (- val-i val-k)) c))
                1
                0)))))))