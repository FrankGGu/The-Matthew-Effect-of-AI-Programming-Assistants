(define (max-score-after-n-operations nums)
  (define nums-vec (list->vector nums))
  (define num-elements (vector-length nums-vec))

  (define memo (make-hash))

  (define (gcd a b)
    (if (zero? b)
        a
        (gcd b (remainder a b))))

  (define (popcount n)
    (let loop ((n n) (count 0))
      (if (zero? n)
          count
          (loop (bitwise-and n (sub1 n)) (add1 count)))))

  (define (solve mask)
    (if (hash-has-key? memo mask)
        (hash-ref memo mask)
        (begin
          (define current-popcount (popcount mask))
          (if (zero? current-popcount)
              (begin (hash-set! memo mask 0) 0)
              (let* ((op-num (+ 1 (/ (- num-elements current-popcount) 2)))
                     (max-score 0))
                (for* ((i (in-range num-elements))
                       (j (in-range (+ i 1) num-elements)))
                  (when (and (not (zero? (bitwise-and mask (arithmetic-shift 1 i))))
                             (not (zero? (bitwise-and mask (arithmetic-shift 1 j)))))
                    (define new-mask (bitwise-xor mask (arithmetic-shift 1 i) (arithmetic-shift 1 j)))
                    (define current-pair-score (* op-num (gcd (vector-ref nums-vec i) (vector-ref nums-vec j))))
                    (set! max-score (max max-score (+ current-pair-score (solve new-mask))))))
                (hash-set! memo mask max-score)
                max-score)))))

  (solve (sub1 (arithmetic-shift 1 num-elements)))) ; Initial mask with all bits set