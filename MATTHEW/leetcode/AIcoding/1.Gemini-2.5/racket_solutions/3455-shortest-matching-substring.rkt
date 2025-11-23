#lang racket

(define (min-window s t)
  (let* ([s-len (string-length s)]
         [t-len (string-length t)])

    (if (zero? t-len)
        "" ; If t is empty, the shortest window is an empty string.
        (let* ([target-counts (make-hash)]
               [window-counts (make-hash)]
               [matched-chars 0] ; Number of unique characters from t whose frequency in window matches target-counts
               [min-length (add1 s-len)] ; Initialize with a value larger than any possible string length
               [min-start 0]
               [left 0])

          (for ([char (string->list t)])
            (hash-set! target-counts char (+ (hash-ref target-counts char 0) 1)))

          (for ([right (in-range s-len)])
            (let ([char-right (string-ref s right)])
              (when (hash-has-key? target-counts char-right)
                (hash-set! window-counts char-right (+ (hash-ref window-counts char-right 0) 1))
                (when (= (hash-ref window-counts char-right) (hash-ref target-counts char-right))
                  (set! matched-chars (+ matched-chars 1)))))

            (while (and (<= left right) (= matched-chars (hash-count target-counts)))
              (let ([current-length (- right left -1)]) ; right - left + 1
                (when (< current-length min-length)
                  (set! min-length current-length)
                  (set! min-start left)))

              (let ([char-left (string-ref s left)])
                (when (hash-has-key? target-counts char-left)
                  (when (= (hash-ref window-counts char-left) (hash-ref target-counts char-left))
                    (set! matched-chars (- matched-chars 1)))
                  (hash-set! window-counts char-left (- (hash-ref window-counts char-left) 1))))
              (set! left (+ left 1))))

          (if (= min-length (add1 s-len))
              ""
              (substring s min-start (+ min-start min-length)))))))