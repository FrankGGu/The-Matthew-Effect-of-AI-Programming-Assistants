#lang racket

(define (num-decodings s)
  (define n (string-length s))
  (define MOD 1000000007)

  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (define current-char (string-ref s (- i 1)))
    (define prev-char (if (>= i 2) (string-ref s (- i 2)) #f))

    ; Ways to decode current-char as a single digit
    (cond
      [(= (char->integer current-char) (char->integer #\*))
       (vector-set! dp i (modulo (+ (vector-ref dp i) (* 9 (vector-ref dp (- i 1)))) MOD))]
      [(not (= (char->integer current-char) (char->integer #\0)))
       (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i 1))) MOD))])

    ; Ways to decode prev-char and current-char as a two-digit number
    (when (>= i 2)
      (cond
        [(= (char->integer prev-char) (char->integer #\*))
         (cond
           [(= (char->integer current-char) (char->integer #\*))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (* 15 (vector-ref dp (- i 2)))) MOD))]
           [(and (char>=? current-char #\0) (char<=? current-char #\6))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (* 2 (vector-ref dp (- i 2)))) MOD))]
           [(and (char>=? current-char #\7) (char<=? current-char #\9))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i 2))) MOD))])]
        [(= (char->integer prev-char) (char->integer #\1))
         (cond
           [(= (char->integer current-char) (char->integer #\*))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (* 9 (vector-ref dp (- i 2)))) MOD))]
           [(and (char>=? current-char #\0) (char<=? current-char #\9))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i 2))) MOD))])]
        [(= (char->integer prev-char) (char->integer #\2))
         (cond
           [(= (char->integer current-char) (char->integer #\*))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (* 6 (vector-ref dp (- i 2)))) MOD))]
           [(and (char>=? current-char #\0) (char<=? current-char #\6))
            (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i 2))) MOD))])]))

  (vector-ref dp n))