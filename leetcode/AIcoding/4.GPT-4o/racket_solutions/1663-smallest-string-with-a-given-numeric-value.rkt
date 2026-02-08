(define (getSmallestString n k)
  (define (helper n k)
    (if (= n 0)
        ""
        (let* ((min-char (max 1 (- k (- n 1) 26)))
               (char (integer->char (+ min-char 96)))
               (new-k (- k min-char)))
          (string-append (string char) (helper (- n 1) new-k)))))
  (helper n k))