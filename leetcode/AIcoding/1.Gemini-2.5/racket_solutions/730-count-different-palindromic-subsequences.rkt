#lang racket

(define (count-palindromic-subsequences s)
  (define N (string-length s))
  (define MOD 1000000007)

  (define dp (build-vector N (lambda (_) (build-vector N (lambda (_) 0)))))

  ;; Precompute next-char and prev-char occurrence arrays
  ;; next-char[i][char_code] = index of next char_code at or after i
  ;;                           N if not found
  ;; prev-char[i][char_code] = index of prev char_code at or before i
  ;;                           -1 if not found
  (define next-char (build-vector N (lambda (_) (build-vector 4 (lambda (_) N)))))
  (define prev-char (build-vector N (lambda (_) (build-vector 4 (lambda (_) -1)))))

  ;; Fill next-char table
  (for ([i (range (- N 1) -1 -1)])
    (for ([char-code (range 4)])
      (vector-set! (vector-ref next-char i) char-code
                   (if (< (+ i 1) N)
                       (vector-ref (vector-ref next-char (+ i 1)) char-code)
                       N)))
    (vector-set! (vector-ref next-char i) (- (char->integer (string-ref s i)) (char->integer #\a)) i))

  ;; Fill prev-char table
  (for ([i (range N)])
    (for ([char-code (range 4)])
      (vector-set! (vector-ref prev-char i) char-code
                   (if (> (- i 1) -1)
                       (vector-ref (vector-ref prev-char (- i 1)) char-code)
                       -1)))
    (vector-set! (vector-ref prev-char i) (- (char->integer (string-ref s i)) (char->integer #\a)) i))

  ;; Fill DP table
  (for ([i (range N)])
    (vector-set! (vector-ref dp i) i 1)) ; Base case: single character is 1 palindrome

  (for ([len (range 2 (add1 N))]) ; len from 2 to N
    (for ([i (range (- N len 0))]) ; i from 0 to N-len
      (define j (+ i len -1))
      (define char-i (string-ref s i))
      (define char-j (string-ref s j))

      (cond
        [(= char-i char-j)
         (define char-code (- (char->integer char-i) (char->integer #\a)))
         (define next-idx (vector-ref (vector-ref next-char (+ i 1)) char-code))
         (define prev-idx (vector-ref (vector-ref prev-char (- j 1)) char-code))

         (cond
           [(> next-idx prev-idx) ; No 'char-i' in s[i+1...j-1]
            (vector-set! (vector-ref dp i) j
                         (modulo (+ (* 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))) 2) MOD))]
           [(= next-idx prev-idx) ; Exactly one 'char-i' in s[i+1...j-1]
            (vector-set! (vector-ref dp i) j
                         (modulo (+ (* 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))) 1) MOD))]
           [else ; Two or more 'char-i' in s[i+1...j-1] (next-idx < prev-idx)
            (vector-set! (vector-ref dp i) j
                         (modulo (- (+ (* 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))) MOD)
                                    (vector-ref (vector-ref dp (+ next-idx 1)) (- prev-idx 1)))
                                 MOD))])]
        [else ; char-i != char-j
         (vector-set! (vector-ref dp i) j
                      (modulo (- (+ (vector-ref (vector-ref dp i) (- j 1))
                                    (vector-ref (vector-ref dp (+ i 1)) j))
                                 (vector-ref (vector-ref dp (+ i 1)) (- j 1))
                                 MOD)
                              MOD))]))

  (vector-ref (vector-ref dp 0) (- N 1)))