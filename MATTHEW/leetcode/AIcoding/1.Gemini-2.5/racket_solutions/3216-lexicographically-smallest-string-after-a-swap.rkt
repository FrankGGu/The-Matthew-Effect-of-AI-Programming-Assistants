#lang racket

(define (lexicographically-smallest-string-after-a-swap s)
  (define n (string-length s))
  (if (<= n 1)
      s
      (let ((chars-vec (string->vector s)))
        (let loop ((i 0))
          (if (>= i (- n 1))
              (vector->string chars-vec)
              (let* ((current-char (vector-ref chars-vec i)))
                (let find-min-loop ((k (+ i 1))
                                    (min-char current-char)
                                    (min-char-idx i))
                  (if (>= k n)
                      (if (char<? min-char current-char)
                          (begin
                            (vector-set! chars-vec i min-char)
                            (vector-set! chars-vec min-char-idx current-char)
                            (vector->string chars-vec))
                          (loop (+ i 1)))
                      (let ((char-at-k (vector-ref chars-vec k)))
                        (cond
                          ((char<? char-at-k min-char)
                           (find-min-loop (+ k 1) char-at-k k))
                          ((char=? char-at-k min-char)
                           (find-min-loop (+ k 1) min-char k))
                          (else
                           (find-min-loop (+ k 1) min-char min-char-idx)))))))))))