(define (monotone-increasing-digits n)
  (let* ([s (string->list (number->string n))]
         [len (length s)]
         [mark len])
    (let loop ([i (- len 1)])
      (when (>= i 1)
        (if (> (char->integer (list-ref s i)) (char->integer (list-ref s (- i 1))))
            (loop (- i 1))
            (begin
              (set! mark i)
              (set! s (list-set s (- i 1) (integer->char (- (char->integer (list-ref s (- i 1))) 1))))
              (loop (- i 1)))))))
    (for ([i (in-range mark len)])
      (set! s (list-set s i #\9)))
    (string->number (list->string s))))