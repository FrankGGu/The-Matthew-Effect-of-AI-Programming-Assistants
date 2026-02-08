(define (thousand-separator n)
  (if (= n 0)
      "0"
      (let* ([s (number->string n)]
             [L (string-length s)])
        (list->string
         (foldr (lambda (char-idx acc-chars)
                  (let* ([char (string-ref s char-idx)]
                         [current-len-from-right (- L char-idx)])
                    (if (and (zero? (modulo current-len-from-right 3))
                             (not (zero? char-idx)))
                        (cons #\. (cons char acc-chars))
                        (cons char acc-chars))))
                '()
                (range 0 L))))))