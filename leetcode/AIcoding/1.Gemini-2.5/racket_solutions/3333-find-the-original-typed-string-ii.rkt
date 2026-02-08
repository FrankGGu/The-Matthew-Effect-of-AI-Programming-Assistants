(define (find-original-typed-string-ii s t)
  (let* ([len-s (string-length s)]
         [len-t (string-length t)])

    (define (helper s-idx t-idx)
      ;; Base case: If we've matched all characters in t
      (cond
        [(= t-idx len-t)
         ;; If we've matched all characters in t,
         ;; we must have also consumed all characters in s.
         (if (= s-idx len-s)
             t
             "")]
        ;; Base case: If we've run out of characters in s but not in t
        [(= s-idx len-s)
         ""]
        ;; Recursive step
        [else
         (let ([s-char (string-ref s s-idx)]
               [t-char (string-ref t t-idx)])
           (if (char=? s-char t-char)
               ;; Characters match, consume all consecutive s-chars
               (let loop ([current-s-idx s-idx])
                 (if (and (< current-s-idx len-s)
                          (char=? (string-ref s current-s-idx) t-char))
                     (loop (+ current-s-idx 1))
                     ;; Finished consuming consecutive s-chars
                     (helper current-s-idx (+ t-idx 1))))
               ;; Characters don't match
               ""))]))

    (helper 0 0)))