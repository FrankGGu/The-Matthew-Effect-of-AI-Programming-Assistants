#lang racket

(define (min-cost-good-caption s)
  (let* ([n (string-length s)]
         [dp (make-vector (+ n 1) +inf.0)])

    (vector-set! dp 0 0)

    (for ([i (in-range 1 (+ n 1))])
      ;; Option 1: Consider taking the character s[i-1] as a "good segment"
      ;; Assume a fixed cost for a single character segment
      (let ([cost-for-single-char-segment 1])
        (when (not (= (vector-ref dp (- i 1)) +inf.0))
          (vector-set! dp i (min (vector-ref dp i)
                                 (+ (vector-ref dp (- i 1)) cost-for-single-char-segment)))))

      ;; Option 2: Consider taking the last two characters s[i-2...i-1] as a "good segment"
      ;; Assume a different fixed cost for a two-character segment
      (when (>= i 2)
        (let ([cost-for-two-char-segment 5])
          ;; Add a placeholder condition for a "good" two-char segment
          ;; For example, if the two characters are the same
          (when (and (not (= (vector-ref dp (- i 2)) +inf.0))
                     (char=? (string-ref s (- i 1)) (string-ref s (- i 2))))
            (vector-set! dp i (min (vector-ref dp i)
                                   (+ (vector-ref dp (- i 2)) cost-for-two-char-segment))))))

      ;; Option 3: Consider taking the last three characters s[i-3...i-1] as a "good segment"
      ;; Assume another fixed cost for a three-character segment
      (when (>= i 3)
        (let ([cost-for-three-char-segment 10])
          ;; Add a placeholder condition for a "good" three-char segment
          ;; For example, if the three characters form a specific pattern
          (when (and (not (= (vector-ref dp (- i 3)) +inf.0))
                     (and (char=? (string-ref s (- i 1)) #\a)
                          (char=? (string-ref s (- i 2)) #\b)
                          (char=? (string-ref s (- i 3)) #\c)))
            (vector-set! dp i (min (vector-ref dp i)
                                   (+ (vector-ref dp (- i 3)) cost-for-three-char-segment)))))))

    (if (= (vector-ref dp n) +inf.0)
        -1
        (vector-ref dp n))))