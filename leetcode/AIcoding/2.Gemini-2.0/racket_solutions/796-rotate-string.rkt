(define (rotate-string s goal)
  (if (and (= (string-length s) (string-length goal))
           (string-contains? (string-append s s) goal))
      #t
      #f))