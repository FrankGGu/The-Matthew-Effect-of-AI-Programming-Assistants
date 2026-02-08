(define (orderly-queue s k)
  (if (= k 1)
      (let loop ([str s] [min-str s])
        (if (string=? str s)
            min-str
            (let* ([rotated-str (string-append (substring str 1) (substring str 0 1))]
                   [new-min-str (if (string<? rotated-str min-str) rotated-str min-str)])
              (loop rotated-str new-min-str))))
      (let* ([char-list (string->list s)]
             [sorted-char-list (sort char-list char<?)]
             [sorted-string (list->string sorted-char-list)])
        sorted-string)))