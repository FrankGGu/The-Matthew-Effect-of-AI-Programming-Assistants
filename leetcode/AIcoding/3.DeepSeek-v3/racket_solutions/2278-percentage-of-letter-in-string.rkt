(define (percentage-letter s letter)
  (let ((count (for/sum ((c (string->list s)))
                  (if (char=? c (string-ref letter 0)) 1 0)))
    (* 100 (/ count (string-length s)))))