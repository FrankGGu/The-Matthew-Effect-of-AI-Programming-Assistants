(define (game-number-guess guess secret)
  (let* ((guess-str (number->string guess))
         (secret-str (number->string secret))
         (a (for/sum ((i (in-range 0 (string-length guess-str))))
              (if (char=? (string-ref guess-str i) (string-ref secret-str i))
                  1
                  0)))
         (b (let loop ((guess-chars (string->list guess-str))
                        (secret-chars (string->list secret-str))
                        (acc 0))
              (cond
                [(empty? guess-chars) acc]
                [else
                 (let ((guess-char (car guess-chars)))
                   (if (member guess-char secret-chars)
                       (loop (cdr guess-chars)
                             (remove guess-char secret-chars #:count 1)
                             (+ acc 1))
                       (loop (cdr guess-chars)
                             secret-chars
                             acc)))]))))
    (list a (- b a))))