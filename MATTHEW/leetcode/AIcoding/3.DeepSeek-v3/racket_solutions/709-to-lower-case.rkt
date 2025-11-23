(define/contract (to-lower-case str)
  (-> string? string?)
  (list->string
   (map (lambda (c)
          (if (and (char<=? #\A c) (char<=? c #\Z))
              (integer->char (+ (char->integer c) 32))
              c))
        (string->list str))))