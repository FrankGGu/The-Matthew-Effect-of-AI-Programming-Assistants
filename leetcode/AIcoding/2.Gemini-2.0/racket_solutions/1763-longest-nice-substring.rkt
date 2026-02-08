(define (longest-nice-substring s)
  (define (is-nice? str)
    (if (string=? str "")
        #t
        (let ([chars (string->list str)])
          (andmap (lambda (c)
                      (let ([other-case (if (char-lower-case? c)
                                            (char-upcase c)
                                            (char-downcase c))])
                        (member c chars #:test char=?))
                      (member other-case chars #:test char=?))
                  (remove-duplicates chars #:test char=?)))))

  (define (find-longest-nice start end)
    (if (>= start end)
        ""
        (let ([sub (substring s start end)])
          (if (is-nice? sub)
              sub
              (let loop ([i start])
                (cond
                  [(>= i end) ""]
                  [else (let* ([c (string-ref s i)]
                                [other-case (if (char-lower-case? c)
                                                 (char-upcase c)
                                                 (char-downcase c))])
                          (if (not (string-contains? s (string c) #:start start #:end end #:test char=?))
                              (let ([left (find-longest-nice start i)]
                                    [right (find-longest-nice (+ i 1) end)])
                                (if (> (string-length left) (string-length right))
                                    left
                                    right))
                              (loop (+ i 1)))))]))))))

  (find-longest-nice 0 (string-length s)))