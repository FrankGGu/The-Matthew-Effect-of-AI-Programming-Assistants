#lang racket

(define (has-equal-freq? s-sub)
  (let* ([len (string-length s-sub)]
         [counts (make-vector 26 0)])

    (when (= len 0)
      (error "has-equal-freq? called with empty string")) ; Should not happen with problem logic

    ; Populate character counts
    (for ([char (in-string s-sub)])
      (let ([idx (- (char->integer char) (char->integer #\a))])
        (vector-set! counts idx (+ (vector-ref counts idx) 1))))

    ; Check if all present characters have the same frequency
    (let loop ([i 0] [target-freq -1])
      (cond
        [(= i 26) #t] ; All characters checked, frequencies are consistent
        [(> (vector-ref counts i) 0) ; If this character appeared
         (if (= target-freq -1)
             ; First character with non-zero count, set target frequency
             (loop (+ i 1) (vector-ref counts i))
             ; Subsequent character with non-zero count, check if it matches target
             (if (= (vector-ref counts i) target-freq)
                 (loop (+ i 1) target-freq)
                 #f))] ; Mismatch found
        [else ; Character did not appear, continue
         (loop (+ i 1) target-freq)]))))

(define (minimum-substring-partition-of-equal-character-frequency s)
  (let* ([n (string-length s)]
         [dp (make-vector (+ n 1) +inf.0)]) ; dp[i] stores min partitions for s[0...i-1]

    (vector-set! dp 0 0) ; Base case: empty prefix needs 0 partitions

    ; Fill dp table
    (for ([i (in-range 1 (+ n 1))]) ; i represents the end index (exclusive) of the prefix
      (for ([j (in-range i)]) ; j represents the start index of the current substring s[j...i-1]
        (let* ([sub-str (substring s j i)])
          (when (has-equal-freq? sub-str)
            (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) 1)))))))

    (vector-ref dp n)))

(define (min-partitions s)
  (minimum-substring-partition-of-equal-character-frequency s))