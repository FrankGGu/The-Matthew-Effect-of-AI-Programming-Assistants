#lang racket

(require racket/string)

(define (decode-string s)
  (define (decode-helper current-idx)
    (let loop ((idx current-idx)
               (current-res "")
               (current-num 0))
      (if (>= idx (string-length s))
          (values current-res idx)
          (let ((char (string-ref s idx)))
            (cond
              ((char-numeric? char)
               (loop (+ idx 1)
                     current-res
                     (+ (* current-num 10) (- (char->integer char) (char->integer #\0)))))
              ((char-alphabetic? char)
               (loop (+ idx 1)
                     (string-append current-res (string char))
                     current-num))
              ((char=? char #\[)
               (let-values (((inner-str next-idx) (decode-helper (+ idx 1))))
                 (loop next-idx
                       (string-append current-res (string-repeat inner-str current-num))
                       0)))
              ((char=? char #\])
               (values current-res (+ idx 1)))
              (else
               (error "Invalid character encountered in string")))))))

  (let-values (((final-str _) (decode-helper 0)))
    final-str))