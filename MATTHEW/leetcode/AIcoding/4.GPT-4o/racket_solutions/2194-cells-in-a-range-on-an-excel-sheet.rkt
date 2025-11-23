(define (cells-in-range s)
  (define start (string->number (substring s 1 2)))
  (define end (string->number (substring s 4 5)))
  (define start-col (string->number (char->integer (string-ref s 0)) -65))
  (define end-col (string->number (char->integer (string-ref s 3)) -65)))
  (for/list ([col (in-range start-col (+ end-col 1))]
              [row (in-range start end)])
    (string-append (string (integer->char (+ col 65))) (number->string row))))