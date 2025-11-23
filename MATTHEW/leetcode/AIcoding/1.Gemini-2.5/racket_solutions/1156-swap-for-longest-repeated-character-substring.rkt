#lang racket

(define (max-rep-char-substring text)
  (define n (string-length text))

  (define char-counts (make-hash))
  (for ([char (in-string text)])
    (hash-update! char-counts char add1 0))

  (define max-len 0)

  (for ([char-code (range (char->integer #\a) (add1 (char->integer #\z)))])
    (define current-char (integer->char char-code))
    (define total-char-count (hash-ref char-counts current-char 0))

    (when (> total-char-count 0)
      (define blocks '())
      (define i 0)
      (while (< i n)
        (when (char=? (string-ref text i) current-char)
          (define j i)
          (while (and (< j n) (char=? (string-ref text j) current-char))
            (set! j (add1 j)))
          (set! blocks (cons (list i j) blocks))
          (set! i j))
        (set! i (add1 i)))
      (set! blocks (reverse blocks))

      (for ([block blocks])
        (define block-start (car block))
        (define block-end (cadr block))
        (define block-len (- block-end block-start))
        (set! max-len (max max-len (min total-char-count (add1 block-len)))))

      (for ([k (range (sub1 (length blocks)))])
        (define block1 (list-ref blocks k))
        (define block2 (list-ref blocks (add1 k)))

        (define block1-start (car block1))
        (define block1-end (cadr block1))
        (define block1-len (- block1-end block1-start))

        (define block2-start (car block2))
        (define block2-end (cadr block2))
        (define block2-len (- block2-end block2-start))

        (when (= (add1 block1-end) block2-start)
          (set! max-len (max max-len (min total-char-count (add1 (+ block1-len block2-len))))))))

  max-len)