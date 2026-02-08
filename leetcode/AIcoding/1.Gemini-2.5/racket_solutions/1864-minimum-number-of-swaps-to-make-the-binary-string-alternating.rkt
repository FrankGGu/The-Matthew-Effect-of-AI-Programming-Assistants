#lang racket

(define (min-swaps s)
  (let* ((n (string-length s))
         (n0 (for/sum ((i (in-range n)))
               (if (eq? (string-ref s i) #\0) 1 0)))
         (n1 (- n n0)))

    (define (calculate-swaps expected-start-char)
      (let ((wrong-pos-count 0))
        (for ((i (in-range n)))
          (let ((current-char (string-ref s i))
                (expected-char (if (even? i)
                                   expected-start-char
                                   (if (eq? expected-start-char #\0) #\1 #\0))))
            (when (not (eq? current-char expected-char))
              (set! wrong-pos-count (+ wrong-pos-count 1)))))
        (/ wrong-pos-count 2)))

    (cond
      ((> (abs (- n0 n1)) 1)
       -1)
      ((= n0 n1)
       (min (calculate-swaps #\0) (calculate-swaps #\1)))
      ((> n0 n1)
       (calculate-swaps #\0))
      (else
       (calculate-swaps #\1)))))