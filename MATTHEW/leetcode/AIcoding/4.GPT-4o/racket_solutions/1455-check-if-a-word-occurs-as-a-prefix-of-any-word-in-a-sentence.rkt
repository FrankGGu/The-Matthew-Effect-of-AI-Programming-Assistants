(define (is-prefix-of-word sentence searchWord)
  (define words (string-split sentence))
  (define (check-prefix word index)
    (if (or (null? word) (= index (length words)))
        -1
        (if (string-prefix? searchWord (list-ref words index))
            (+ index 1)
            (check-prefix word (+ index 1)))))
  (check-prefix searchWord 0))