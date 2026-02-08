#lang racket
(require racket/string)

(define (solution s)
  (let* ((len (string-length s)))
    (if (< len 2)
        #f
        (let loop ((i 0))
          (if (>= i (- len 1))
              #f
              (let* ((sub (substring s i (+ i 2)))
                     (rev-sub (string-reverse sub)))
                (if (string-contains? s rev-sub)
                    #t
                    (loop (+ i 1)))))))))