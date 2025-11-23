(define (merge-strings-alternately str1 str2)
  (define (merge-helper s1 s2 result)
    (cond
      [(and (string=? s1 "") (string=? s2 "")) result]
      [else
       (merge-helper
         (if (not (string=? s1 ""))
             (substring s1 1)
             "")
         (if (not (string=? s2 ""))
             (substring s2 1)
             "")
         (string-append result
                        (if (not (string=? s1 ""))
                            (string (string-ref s1 0))
                            "")
                        (if (not (string=? s2 ""))
                            (string (string-ref s2 0))
                            "")))]))
  (merge-helper str1 str2 ""))