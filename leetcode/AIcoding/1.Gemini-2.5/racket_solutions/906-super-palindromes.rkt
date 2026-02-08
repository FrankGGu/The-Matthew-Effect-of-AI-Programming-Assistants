#lang racket

(require racket/string)

(define (is-palindrome? s)
  (string=? s (string-reverse s)))

(define (super-palindromes L R)
  (define min-val (string->number L))
  (define max-val (string->number R))
  (define count 0)
  (define stop-processing? #f)

  ;; Iterate 'i' which forms the first half of the palindrome.
  ;; The largest palindrome 'p' we need to consider is sqrt(10^18) = 10^9.
  ;; If p is 999,999,999 (9 digits), its first half is "99999" (5 digits).
  ;; If p is 10^9 (10 digits), its first half is "10000" (5 digits).
  ;; So 'i' needs to go up to 99999. (in-range 1 100000) covers this.
  (for ([i (in-range 1 100000)]
        #:when (not stop-processing?)) ; Stop outer loop if flag is set
    (define s_i (number->string i))
    (define s_i-rev (string-reverse s_i))

    (define (process-palindrome p_str)
      (unless stop-processing? ; Only proceed if not stopped by a previous check
        (define p_num (string->number p_str))

        ;; Optimization: if p_num is already greater than 10^9, its square
        ;; will definitely be greater than 10^18 (max possible R), so we can stop.
        (when (> p_num 1000000000) ; 10^9
          (set! stop-processing? #t))

        (unless stop-processing?
          (define p_squared (* p_num p_num))

          ;; If p_squared exceeds max-val, then all subsequent palindromes
          ;; generated from larger 'i' will also have squares exceeding max-val.
          ;; So we can stop the entire process.
          (when (> p_squared max-val)
            (set! stop-processing? #t))

          (unless stop-processing?
            (when (and (>= p_squared min-val) (<= p_squared max-val))
              (when (is-palindrome? (number->string p_squared))
                (set! count (+ count 1))))))))

    ;; Generate odd-length palindrome: s_i + reverse(s_i excluding last char)
    (process-palindrome (string-append s_i (string-reverse (substring s_i 0 (- (string-length s_i) 1)))))

    ;; Generate even-length palindrome: s_i + reverse(s_i)
    (process-palindrome (string-append s_i s_i-rev)))

  count)