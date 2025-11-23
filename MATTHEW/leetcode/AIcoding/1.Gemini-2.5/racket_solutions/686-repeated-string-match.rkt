#lang racket
(require racket/string)

(define (repeated-string-match a b)
  (let* ((len-a (string-length a))
         (len-b (string-length b))
         (min-repeats (ceiling (/ len-b len-a))))

    (let loop ((k min-repeats))
      (cond
        ((> k (+ min-repeats 2)) -1)
        (else
         (let ((current-s (string-repeat a k)))
           (if (string-contains? current-s b)
               k
               (loop (+ k 1)))))))))