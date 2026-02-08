#lang racket

(define (find-substring-in-wraparound-string p)
  (define n (string-length p))
  (when (zero? n)
    0)

  (define a-code (char->integer #\a))
  (define z-code (char->integer #\z))

  (define max-len (make-vector 26 0))
  (define current-max-len 0)

  (for ([i (in-range n)])
    (define current-char (string-ref p i))
    (define current-char-code (char->integer current-char))
    (define current-char-idx (- current-char-code a-code))

    (if (zero? i)
        (set! current-max-len 1)
        (begin
          (define prev-char (string-ref p (- i 1)))
          (define prev-char-code (char->integer prev-char))

          (if (or (= (- current-char-code prev-char-code) 1)
                  (and (= prev-char-code z-code)
                       (= current-char-code a-code)))
              (set! current-max-len (+ current-max-len 1))
              (set! current-max-len 1))))

    (vector-set! max-len current-char-idx (max (vector-ref max-len current-char-idx)
                                               current-max-len)))

  (apply + (vector->list max-len)))