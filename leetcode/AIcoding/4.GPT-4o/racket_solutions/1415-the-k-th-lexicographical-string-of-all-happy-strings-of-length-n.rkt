(define (get-happy-strings n k)
  (define (generate happy-string)
    (if (= (string-length happy-string) n)
        (begin
          (set! count (+ count 1))
          (when (= count k)
            (set! result happy-string)))
        (for-each (lambda (c)
                    (when (or (string-empty? happy-string)
                              (not (= (string-ref happy-string (- (string-length happy-string) 1)) c)))
                      (generate (string-append happy-string (string c)))))
                  (list #\a #\b #\c))))

  (define result "")
  (define count 0)
  (generate "")
  (if (string=? result "") "" result))

(get-happy-strings 1 1) ; "a"
(get-happy-strings 1 2) ; "b"
(get-happy-strings 3 9) ; "cab"