(define (breakPalindrome palindrome)
  (if (zero? (string-length palindrome))
      ""
      (let loop ((i 0))
        (cond
          ((= i (sub1 (string-length palindrome))) 
           (if (= (string-length palindrome) 1) 
               "" 
               (string-append "a" (substring palindrome 1))))
          ((char=? (string-ref palindrome i) #\a) 
           (loop (add1 i)))
          (else 
           (string-append (substring palindrome 0 i) 
                          "a" 
                          (substring palindrome (add1 i))))))))

(breakPalindrome "abccba")