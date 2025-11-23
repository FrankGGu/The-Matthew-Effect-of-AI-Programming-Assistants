#lang racket

(define (shift-distance s t)
  (let ((len-s (string-length s))
        (len-t (string-length t)))
    (cond
      ((not (= len-s len-t)) -1) ; Strings must have the same length
      ((= len-s 0) 0) ; Both empty strings, 0 shifts
      ((string=? s t) 0) ; Already equal, 0 shifts
      (else
       (let ((s-double (string-append s s)))
         (let ((idx (string-find s-double t)))
           (if idx
               idx
               -1)))))))