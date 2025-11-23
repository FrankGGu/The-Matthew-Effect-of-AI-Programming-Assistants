(define (construct-longest-new-string n)
  (if (<= n 0)
      ""
      (let loop ((remaining n) (result ""))
        (if (= remaining 0)
            result
            (if (even? remaining)
                (loop (- remaining 1) (string-append result "a"))
                (loop (- remaining 2) (string-append result "ab")))))))

(define (longestNewString n)
  (construct-longest-new-string n))