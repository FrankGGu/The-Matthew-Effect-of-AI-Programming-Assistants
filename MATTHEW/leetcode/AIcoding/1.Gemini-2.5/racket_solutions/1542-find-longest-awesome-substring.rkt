(define (longest-awesome s)
  (let* ([n (string-length s)]
         [dp (make-hash)] ; Stores (mask . smallest-prefix-length-achieving-mask)
         [current-mask 0]
         [max-len 0])

    (hash-set! dp 0 0) ; An empty prefix (length 0) has mask 0

    (for ([j (in-range n)])
      (let* ([digit (- (char->integer (string-ref s j)) (char->integer #\0))]
             [bit (expt 2 digit)])
        (set! current-mask (xor current-mask bit))

        ; Case 1: Substring s[prev_idx...j] has all even counts (mask 0)
        ; This means current_mask == prefix_mask[prev_idx]
        (when (hash-has-key? dp current-mask)
          (let ([prev-idx (hash-ref dp current-mask)])
            (set! max-len (max max-len (- (+ j 1) prev-idx)))))

        ; Case 2: Substring s[prev_idx...j] has exactly one odd count (mask is a power of 2)
        ; This means current_mask XOR prefix_mask[prev_idx] == (1 << k)
        ; So, prefix_mask[prev_idx] == current_mask XOR (1 << k)
        (for ([k (in-range 10)]) ; Iterate for digits 0-9
          (let ([target-mask (xor current-mask (expt 2 k))])
            (when (hash-has-key? dp target-mask)
              (let ([prev-idx (hash-ref dp target-mask)])
                (set! max-len (max max-len (- (+ j 1) prev-idx)))))))

        ; Store the current mask with its smallest prefix length
        ; Only store if it's the first time we've seen this mask
        (when (not (hash-has-key? dp current-mask))
          (hash-set! dp current-mask (+ j 1)))))
    max-len))