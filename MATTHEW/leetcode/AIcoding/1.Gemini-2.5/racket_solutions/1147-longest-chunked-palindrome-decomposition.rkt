(define (longest-chunked-palindrome-decomposition text)
  (let* ((n (string-length text))
         (P 257) ; A prime base, chosen to be larger than typical ASCII character values
         (M 1000000007) ; A large prime modulus
         (powers (make-vector (+ n 1))) ; powers[i] = P^i % M
         (hashes (make-vector (+ n 1)))) ; hashes[i] = hash of text[0...i-1] % M

    ;; Precompute powers of P modulo M
    (vector-set! powers 0 1)
    (for ((i 1) (< i (+ n 1)))
      (vector-set! powers i (modulo (* (vector-ref powers (- i 1)) P) M)))

    ;; Precompute prefix hashes
    ;; hashes[i] stores the hash of the substring text[0...i-1]
    (vector-set! hashes 0 0)
    (for ((i 1) (< i (+ n 1)))
      (vector-set! hashes i
                   (modulo (+ (modulo (* (vector-ref hashes (- i 1)) P) M)
                              (char->integer (string-ref text (- i 1)))) ; Use char->integer directly for character value
                           M)))

    ;; Helper function to get the hash of the substring text[start...start+len-1]
    (define (get-hash start len)
      (if (zero? len)
          0
          (let* ((h-end (vector-ref hashes (+ start len)))
                 (h-start (vector-ref hashes start))
                 (p-len (vector-ref powers len)))
            ;; Calculate hash(text[start...start+len-1]) = (hashes[start+len] - hashes[start] * P^len) % M
            ;; Handle negative results from Racket's modulo for negative numbers
            (modulo (+ (- h-end (modulo (* h-start p-len) M)) M) M))))

    ;; The main recursive function to find the maximum number of chunks
    ;; current-start and current-end define the current segment of the string (exclusive end)
    (let loop ((current-start 0) (current-end n))
      (let ((current-len (- current-end current-start)))
        (cond
          ((zero? current-len) 0) ; Empty string segment, no chunks
          ((= current-len 1) 1) ; Single character segment, one chunk
          (else
           ;; Iterate through possible lengths for the outermost matching chunks
           (let found-match ((len 1))
             (cond
               ((> len (/ current-len 2)) 1) ; No matching prefix/suffix found, entire segment is one chunk
               (else
                (let ((prefix-hash (get-hash current-start len))
                      (suffix-hash (get-hash (- current-end len) len)))
                  (if (= prefix-hash suffix-hash)
                      ;; If hashes match, we found a pair of chunks.
                      ;; Recursively solve for the middle part and add 2 to the count.
                      (+ 2 (loop (+ current-start len) (- current-end len)))
                      ;; If hashes don't match, try a longer prefix/suffix
                      (found-match (+ len 1))))))))))))