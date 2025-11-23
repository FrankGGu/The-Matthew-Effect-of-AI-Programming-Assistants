#lang racket

(define (find-kth-char n k)
  (define (helper m)
    (if (= m 1)
        #\a
        (let* ((prev (helper (- m 1)))
               (len (string-length prev))
               (new-len (+ len 1)))
          (string-ref (string-append prev (make-string 1 (integer->char (+ 97 (string-length prev))))) (- k 1)))))
  (helper n))