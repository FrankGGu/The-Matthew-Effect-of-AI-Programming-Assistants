#lang racket

(define (longest-substring-with-at-least-k-repeating-characters s k)
  (define (helper s start end k)
    (if (> start end) 0
        (let ((count (make-hash)))
          (for ([c (in-string s start end)])
            (hash-update! count c add1 0))
          (let loop ([i start] [j start] [max-len 0])
            (if (>= j end)
                max-len
                (let ((c (string-ref s j)))
                  (if (< (hash-ref count c) k)
                      (loop (add1 j) (add1 j) max-len)
                      (loop i (add1 j) (max max-len (- j i +1))))))))))
  (helper s 0 (string-length s) k))