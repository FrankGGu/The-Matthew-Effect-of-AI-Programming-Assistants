#lang racket

(define (make-largest-special s)
  (let loop ((idx 0)
             (balance 0)
             (start 0)
             (sub-strings '()))
    (cond
      ((= idx (string-length s))
       (string-join (sort sub-strings string>?) ""))
      (else
       (let* ((char (string-ref s idx))
              (new-balance (if (char=? char #\1)
                               (+ balance 1)
                               (- balance 1))))
         (if (= new-balance 0)
             (let* ((inner-s (substring s (+ start 1) idx))
                    (processed-inner (make-largest-special inner-s))
                    (current-special-str (string-append "1" processed-inner "0")))
               (loop (+ idx 1) 0 (+ idx 1) (cons current-special-str sub-strings)))
             (loop (+ idx 1) new-balance start sub-strings)))))))