(define (is-valid-word word)
  (let ((count 0))
    (for ([c (string->list word)])
      (when (char=? c #\#)
        (set! count (+ count 1))))
    (= count 1)))

(define (isValidWord word)
  (is-valid-word word))