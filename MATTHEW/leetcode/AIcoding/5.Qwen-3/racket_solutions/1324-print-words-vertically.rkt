#lang racket

(define (print-words-vertically words)
  (define (char-at s i)
    (if (< i (string-length s))
        (string-ref s i)
        #\space))

  (define max-len (apply max (map string-length words)))

  (define (row i)
    (list->string
     (map (lambda (word) (char-at word i)) words)))

  (define (trim s)
    (let loop ((s s) (i 0))
      (if (or (= i (string-length s)) (not (char=? #\space (string-ref s i))))
          s
          (loop s (+ i 1)))))

  (map trim (map row (range max-len))))