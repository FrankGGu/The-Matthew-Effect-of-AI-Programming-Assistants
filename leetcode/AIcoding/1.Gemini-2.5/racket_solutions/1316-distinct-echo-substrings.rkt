#lang racket

(define (distinct-echo-substrings text)
  (let* ((n (string-length text))
         (p1 31) ; Prime base for hash function 1
         (m1 1000000007) ; Modulo for hash function 1
         (p2 37) ; Prime base for hash function 2
         (m2 1000000009) ; Modulo for hash function 2

         ;; h1[k] stores the hash of text[0...k-1] using p1, m1
         (h1 (make-vector (+ n 1) 0))
         ;; p1-powers[k] stores p1^k mod m1
         (p1-powers (make-vector (+ n 1) 1))

         ;; h2[k] stores the hash of text[0...k-1] using p2, m2
         (h2 (make-vector (+ n 1) 0))
         ;; p2-powers[k] stores p2^k mod m2
         (p2-powers (make-vector (+ n 1) 1)))

    ;; Precompute powers and rolling hashes
    (for ((k (in-range 1 (+ n 1))))
      ;; Calculate p^k
      (vector-set! p1-powers k (modulo (* (vector-ref p1-powers (- k 1)) p1) m1))
      (vector-set! p2-powers k (modulo (* (vector-ref p2-powers (- k 1)) p2) m2))

      ;; Calculate rolling hash
      (let* ((char-val (char->integer (string-ref text (- k 1))))
             (prev-h1 (vector-ref h1 (- k 1)))
             (prev-h2 (vector-ref h2 (- k 1))))
        (vector-set! h1 k (modulo (+ (* prev-h1 p1) char-val) m1))
        (vector-set! h2 k (modulo (+ (* prev-h2 p2) char-val) m2))))

    ;; Helper function to get the hash of substring text[start...end-1]
    (define (get-substring-hash current-h powers p m start end)
      (let* ((len (- end start))
             (hash-at-end (vector-ref current-h end))
             (hash-at-start (vector-ref current-h start))
             (power-for-len (vector-ref powers len)))
        ;; Formula: (hash[end] - hash[start] * p^len) mod m
        ;; Add m to ensure positive result before final modulo
        (modulo (+ hash-at-end
                   (- (modulo (* hash-at-start power-for-len) m))
                   m)
                m)))

    (define distinct-echo-hashes (set))

    ;; Iterate through all possible starting positions 'i' for the first half
    (for ((i (in-range 0 n)))
      ;; Iterate through all possible lengths 'len' for the first half 's'
      ;; The full echo substring 's+s' has length 2*len.
      ;; It must fit within the string 'text', so i + 2*len <= n.
      ;; This implies len <= (n - i) / 2.
      ;; The maximum value for 'len' is (floor ((n - i) / 2)).
      (for ((len (in-range 1 (add1 (quotient (- n i) 2)))))
        (let* ((start1 i)
               (end1 (+ i len))
               (start2 (+ i len))
               (end2 (+ i (* 2 len))))

          ;; Calculate the pair of hashes for the first half (s1)
          (let* ((s1-hash1 (get-substring-hash h1 p1-powers p1 m1 start1 end1))
                 (s1-hash2 (get-substring-hash h2 p2-powers p2 m2 start1 end1))
                 ;; Calculate the pair of hashes for the second half (s2)
                 (s2-hash1 (get-substring-hash h1 p1-powers p1 m1 start2 end2))
                 (s2-hash2 (get-substring-hash h2 p2-powers p2 m2 start2 end2)))

            ;; If both hash pairs match, then s1 and s2 are highly likely to be identical
            (when (and (= s1-hash1 s2-hash1)
                       (= s1-hash2 s2-hash2))
              ;; Add the hash pair of the echo substring (s1+s2) to the set
              ;; We use the hash of s1 as the representative for the echo substring
              (set! distinct-echo-hashes (set-add distinct-echo-hashes (list s1-hash1 s1-hash2))))))))

    ;; The number of distinct echo substrings is the size of the set
    (set-count distinct-echo-hashes)))