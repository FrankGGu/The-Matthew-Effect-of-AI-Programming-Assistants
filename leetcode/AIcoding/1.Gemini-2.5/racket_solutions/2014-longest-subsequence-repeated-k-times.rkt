#lang racket

(define (longest-subsequence-repeated-k-times s k)
  (define s-len (string-length s))

  ;; Precompute next-char table
  ;; next-char[i][char-code] stores the smallest index j >= i such that s[j] == char
  ;; If not found, it stores s-len.
  (define next-char-table (make-vector (+ s-len 1)))
  (for ([i (in-range (+ s-len 1))])
    (vector-set! next-char-table i (make-vector 26 s-len))) ; Initialize with s-len (not found)

  ;; Fill next-char table from right to left
  (for ([i (in-range (- s-len 1) -1 -1)])
    (define current-row (vector-ref next-char-table i))
    (define next-row (vector-ref next-char-table (+ i 1)))
    (for ([char-code (in-range 26)])
      (vector-set! current-row char-code (vector-ref next-row char-code)))
    (vector-set! current-row (- (char->integer (string-ref s i)) (char->integer #\a)) i))

  ;; Helper function to find the next occurrence of sub as a subsequence
  ;; Returns the index in s *after* the matched subsequence, or s-len if not found.
  (define (find-sub sub start-idx)
    (define sub-len (string-length sub))
    (let loop ([sub-char-idx 0] [current-s-idx start-idx])
      (cond
        [(= sub-char-idx sub-len) current-s-idx] ; All chars of sub matched
        [else
         (define char-code (- (char->integer (string-ref sub sub-char-idx)) (char->integer #\a)))
         (define next-match-s-idx (vector-ref (vector-ref next-char-table current-s-idx) char-code))
         (if (= next-match-s-idx s-len) ; If char not found from current-s-idx
             s-len ; Return s-len to indicate not found
             (loop (+ sub-char-idx 1) (+ next-match-s-idx 1)))]))) ; Move past the matched char for next search

  ;; Helper function to check if sub is a subsequence of s repeated k times
  (define (is-subsequence-repeated-k-times? sub)
    (let loop ([count 0] [current-s-idx 0])
      (cond
        [(= count k) #t] ; Found k times
        [else
         (define next-s-idx (find-sub sub current-s-idx))
         (if (= next-s-idx s-len)
             #f ; Not found k times
             (loop (+ count 1) next-s-idx)))])))

  (define ans "")

  ;; DFS to build candidate subsequences
  (define (dfs current-sub)
    ;; Update global answer if current-sub is better
    (when (> (string-length current-sub) (string-length ans))
      (set! ans current-sub))
    (when (and (= (string-length current-sub) (string-length ans))
               (string>? current-sub ans))
      (set! ans current-sub))

    ;; Try appending characters from 'z' down to 'a'
    (for ([char-code (in-range 25 -1 -1)]) ; From 25 ('z') down to 0 ('a')
      (define c (integer->char (+ (char->integer #\a) char-code)))
      (define next-sub (string-append current-sub (string c)))
      (when (is-subsequence-repeated-k-times? next-sub)
        (dfs next-sub))))

  ;; Start DFS from empty string
  (dfs "")
  ans)