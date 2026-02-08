#lang racket

(require racket/vector)

(define (num-ways words target)
  (define MOD 1000000007)

  (define num-words (length words))
  (define word-len (string-length (car words)))
  (define target-len (string-length target))

  (define char-counts (make-vector word-len (make-vector 26 0)))

  (for ([word words])
    (for ([k (in-range word-len)])
      (define char-code (- (char->integer (string-ref word k)) (char->integer #\a)))
      (vector-set! (vector-ref char-counts k) char-code
                   (+ (vector-ref (vector-ref char-counts k) char-code) 1))))

  (define dp (make-vector (+ target-len 1) 0))
  (vector-set! dp 0 1)

  (for ([j (in-range word-len)])
    (define current-col-char-counts (vector-ref char-counts j))
    (define prev-dp-val-for-i-minus-1 (vector-ref dp 0))

    (for ([i (in-range 1 (+ target-len 1))])
      (define temp-dp-val-for-i (vector-ref dp i))

      (define current-target-char-code (- (char->integer (string-ref target (- i 1))) (char->integer #\a)))
      (define char-freq (vector-ref current-col-char-counts current-target-char-code))

      (define ways-using-current-col (* prev-dp-val-for-i-minus-1 char-freq))

      (vector-set! dp i (modulo (+ (vector-ref dp i) ways-using-current-col) MOD))

      (set! prev-dp-val-for-i-minus-1 temp-dp-val-for-i)))

  (vector-ref dp target-len))