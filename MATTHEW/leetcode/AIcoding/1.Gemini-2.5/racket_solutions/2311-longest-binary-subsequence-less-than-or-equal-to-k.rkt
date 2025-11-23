#lang racket

(define (longest-binary-subsequence-less-than-or-equal-to-k s k)
  (let* ([n (string-length s)])
    (let-values (((final-ans _ __)
                  (for/fold ([ans 0]
                             [current-val 0]
                             [power 0])
                            ([i (range (- n 1) -1 -1)])
                    (let ([char (string-ref s i)])
                      (cond
                        [(char=? char #\0)
                         (values (+ ans 1) current-val power)]
                        [(char=? char #\1)
                         (if (<= (+ current-val (expt 2 power)) k)
                             (values (+ ans 1) (+ current-val (expt 2 power)) (+ power 1))
                             (values ans current-val (+ power 1)))]
                        [else
                         (values ans current-val power)])))))
      final-ans)))