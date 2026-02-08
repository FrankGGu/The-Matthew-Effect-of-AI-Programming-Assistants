(define (get-lucky s k)
  (define (char-to-digit-string char)
    (number->string (+ (- (char->integer char) (char->integer #\a)) 1)))

  (define initial-num-str
    (string-append* (for/list ([char (string->list s)])
                      (char-to-digit-string char))))

  (define (sum-digits-of-string num-str)
    (define (char-to-int char)
      (- (char->integer char) (char->integer #\0)))
    (foldl + 0 (map char-to-int (string->list num-str))))

  (define (transform current-str count)
    (if (= count 0)
        (string->number current-str)
        (transform (number->string (sum-digits-of-string current-str))
                   (- count 1))))

  (transform initial-num-str k))