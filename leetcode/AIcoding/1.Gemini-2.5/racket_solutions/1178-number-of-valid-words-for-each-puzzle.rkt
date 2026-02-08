#lang racket

(define (char->bit c)
  (- (char->integer c) (char->integer #\a)))

(define (string->mask s)
  (for/fold ([mask 0])
            ([c (in-string s)])
    (bitwise-ior mask (arithmetic-shift 1 (char->bit c)))))

(define (find-num-of-valid-words words puzzles)
  (define word-masks (make-hash))

  (for ([word words])
    (hash-update! word-masks (string->mask word) add1 0))

  (for/list ([puzzle puzzles])
    (define puzzle-mask (string->mask puzzle))
    (define first-char-bit (arithmetic-shift 1 (char->bit (stringref puzzle 0))))
    (define valid-count 0)

    (let loop ([sub-mask puzzle-mask])
      (when (= (bitwise-and sub-mask first-char-bit) first-char-bit)
        (set! valid-count (+ valid-count (hash-ref word-masks sub-mask 0))))

      (when (> sub-mask 0)
        (loop (bitwise-and sub-mask (sub1 sub-mask)))))

    valid-count))