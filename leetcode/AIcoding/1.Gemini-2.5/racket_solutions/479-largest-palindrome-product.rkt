#lang racket

(define (largest-palindrome n)
  (if (= n 1)
      9
      (let* ((upper-bound (- (expt 10 n) 1))
             (lower-bound (expt 10 (- n 1)))
             (mod-val 1337))
        (for/first ((i (in-range upper-bound lower-bound -1)))
          (let* ((s-i (number->string i))
                 (s-rev (string-reverse s-i))
                 (palindrome (string->number (string-append s-i s-rev))))
            (for/first ((j (in-range upper-bound (max lower-bound (ceiling (/ palindrome upper-bound))) -1)))
              (when (and (= (remainder palindrome j) 0)
                         (>= (/ palindrome j) lower-bound)
                         (<= (/ palindrome j) upper-bound))
                (remainder palindrome mod-val))))))))