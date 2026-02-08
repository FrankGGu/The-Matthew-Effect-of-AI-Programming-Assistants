#lang racket

(define (count-substrings-divisible-by-last-digit s)
  (let ((n (string-length s)))
    (for/sum ((i (range n)))
      (for/sum ((j (range i n)))
        (let* ((last-char (string-ref s j))
               (divisor (- (char->integer last-char) (char->integer #\0))))
          (if (= divisor 0)
              0
              (let* ((sub-str (substring s i (+ j 1)))
                     (num (string->number sub-str)))
                (if (= (remainder num divisor) 0)
                    1
                    0))))))))