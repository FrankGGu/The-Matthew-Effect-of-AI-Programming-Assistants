(define/contract (is-sum-equal firstWord secondWord targetWord)
  (-> string? string? string? boolean?)
  (define (word->num word)
    (string->number
     (list->string
      (for/list ([c (in-string word)])
        (integer->char (+ (char->integer #\a) (- (char->integer c) (char->integer #\a)))))))
  (let ([num1 (word->num firstWord)]
        [num2 (word->num secondWord)]
        [target (word->num targetWord)])
    (= (+ num1 num2) target)))