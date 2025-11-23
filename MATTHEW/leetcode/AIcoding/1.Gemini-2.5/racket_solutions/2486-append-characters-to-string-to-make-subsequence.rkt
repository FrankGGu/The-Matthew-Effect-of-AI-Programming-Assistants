(define (append-characters-to-string-to-make-subsequence s t)
  (let* ((len-s (string-length s))
         (len-t (string-length t)))
    (let loop ((i 0) ; Pointer for string s
               (j 0)) ; Pointer for string t
      (cond
        ((= j len-t) ; All characters of t have been found as a subsequence in s
         0)
        ((= i len-s) ; String s has been exhausted, but not all of t was found
         (- len-t j))
        (else
         (if (char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1)) ; Characters match, advance both pointers
             (loop (+ i 1) j))))))) ; Characters don't match, only advance s pointer