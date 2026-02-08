(define (select-k-disjoint-special-substrings s k)
  (define n (string-length s))
  (define mod 1000000007)

  ;; dp[i][j] = number of ways to select j disjoint special substrings from s[0...i-1]
  ;; i goes from 0 to n (representing prefix length)
  ;; j goes from 0 to k (representing number of substrings)
  (define dp (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ k 1) 0)))

  ;; Base case: There is 1 way to select 0 substrings (by selecting nothing)
  (for ([i (in-range (+ n 1))])
    (vector-set! (vector-ref dp i) 0 1))

  (for ([i (in-range 1 (+ n 1))]) ; Iterate through prefix lengths (from 1 to n)
    (for ([j (in-range 1 (+ k 1))]) ; Iterate through number of substrings (from 1 to k)
      ;; Option 1: Do not include s[i-1] in any selected special substring.
      ;; The j substrings are selected from s[0...i-2].
      (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j))

      ;; Option 2: Include s[p...i-1] as the j-th special substring.
      ;; The remaining j-1 substrings must be selected from s[0...p-1].
      (define current-zeros 0)
      (define current-ones 0)
      ;; Iterate p-idx from i-1 down to 0 (p-idx is the start index of the potential substring)
      (for ([p-idx (in-range (- i 1) -1 -1)])
        (let ([char (string-ref s p-idx)])
          (if (char=? char #\0)
              (set! current-zeros (+ current-zeros 1))
              (set! current-ones (+ current-ones 1))))

        (when (= current-zeros current-ones)
          ;; s[p-idx ... i-1] is a special substring
          ;; Add ways from dp[p-idx][j-1]
          (let* ([prev-ways (vector-ref (vector-ref dp p-idx) (- j 1))]
                 [current-val (vector-ref (vector-ref dp i) j)])
            (vector-set! (vector-ref dp i) j (modulo (+ current-val prev-ways) mod)))))))

  (vector-ref (vector-ref dp n) k))