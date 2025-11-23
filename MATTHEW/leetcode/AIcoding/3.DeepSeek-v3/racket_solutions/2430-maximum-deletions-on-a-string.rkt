#lang racket

(define (delete-string s)
  (let loop ([s s] [steps 0])
    (if (string=? s "")
        steps
        (let ([n (string-length s)])
          (let ([found #f] [k 0])
            (for ([i (in-range 1 (add1 (quotient n 2)))]
                  #:break found)
              (let ([prefix (substring s 0 i)]
                    [suffix (substring s (- n i) n)])
                (when (string=? prefix suffix)
                  (set! found #t)
                  (set! k i))))
            (if found
                (loop (substring s k) (add1 steps))
                (loop "" (add1 steps))))))))