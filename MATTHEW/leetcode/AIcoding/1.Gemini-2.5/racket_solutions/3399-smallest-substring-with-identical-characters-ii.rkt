(define (smallest-substring-with-identical-characters-ii s)
  (let* ((n (string-length s))
         (freq (make-vector 26 0))) ; Frequency array for 'a' through 'z'

    ; Count character frequencies
    (for ((i (in-range n)))
      (let* ((char (string-ref s i))
             (idx (- (char->integer char) (char->integer #\a)))
             (current-count (vector-ref freq idx)))
        (vector-set! freq idx (add1 current-count))))

    ; Check if any character appears at least twice
    ; If yes, the smallest valid substring is of length 1
    (let loop ((i 0))
      (cond
        ((= i 26) -1) ; No character appeared >= 2 times
        ((>= (vector-ref freq i) 2) 1) ; Found one, return 1
        (else (loop (add1 i)))))))