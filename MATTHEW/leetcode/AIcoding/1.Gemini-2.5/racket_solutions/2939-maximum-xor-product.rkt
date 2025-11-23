(define (maximum-xor-product a b n)
  (let* ((MOD 1000000007)
         (xor-val (bitwise-xor a b))
         (and-val (bitwise-and a b))
         (mask-n (- (arithmetic-shift 1 n) 1)) ; (1 << n) - 1, a mask with n low bits set to 1

         ; Calculate the part of max-and-val for bits 0 to n-1.
         ; For these bits, if (xor-val)_i is 0 (i.e., a_i = b_i), we can make (a' AND b')_i = 1.
         ; If (xor-val)_i is 1 (i.e., a_i != b_i), (a' AND b')_i must be 0.
         ; This is equivalent to (~(xor-val & mask-n)) & mask-n.
         ; In Racket, for a number X and a mask M (all ones up to a certain bit),
         ; (~X) & M is equivalent to (bitwise-xor X M).
         (max-and-val-low-bits (bitwise-xor (bitwise-and xor-val mask-n) mask-n))

         ; Calculate the part of max-and-val for bits n and higher.
         ; For these bits, x is effectively 0, so a'_i = a_i and b'_i = b_i.
         ; Thus, (a' AND b')_i = (a AND b)_i.
         ; This is equivalent to (and-val & (~mask-n)).
         (max-and-val-high-bits (bitwise-and and-val (bitwise-not mask-n)))

         ; Combine the low and high bits to get the maximum possible value for (a' AND b').
         (max-and-val (bitwise-ior max-and-val-low-bits max-and-val-high-bits)))

    ; The final result is (a XOR b) * (maximized (a' AND b')) modulo MOD.
    (modulo (* xor-val max-and-val) MOD)))