(define (num-matching-subseq s words)
  (define (is-subseq word)
    (let loop ((w word) (i 0))
      (if (null? w)
          #t
          (if (>= i (string-length s))
              #f
              (if (char=? (car w) (string-ref s i))
                  (loop (cdr w) (+ i 1))
                  (loop w (+ i 1)))))))
  (define (count-matching words)
    (length (filter is-subseq words)))
  (count-matching words))