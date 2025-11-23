(define (generate-happy-strings n)
  (define (generate-helper current-string length)
    (cond
      ((= length 0) (list current-string))
      (else
       (let ((last-char (if (empty? current-string) #\space (last (string->list current-string)))))
         (append
          (if (not (char=? last-char #\a)) (generate-helper (string-append current-string "a") (- length 1)) '())
          (if (not (char=? last-char #\b)) (generate-helper (string-append current-string "b") (- length 1)) '())
          (if (not (char=? last-char #\c)) (generate-helper (string-append current-string "c") (- length 1)) '()))))))
  (sort (generate-helper "" n) string<?))

(define (get-happy-string n k)
  (let* ((happy-strings (generate-happy-strings n))
         (num-strings (length happy-strings)))
    (if (> k num-strings)
        ""
        (list-ref happy-strings (- k 1)))))