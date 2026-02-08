(define (is-sum-equal firstWord secondWord targetWord)
  (define (word->value word-str)
    (let loop ((chars (string->list word-str))
               (acc 0))
      (if (empty? chars)
          acc
          (let* ((char (car chars))
                 (digit (- (char->integer char) (char->integer #\a))))
            (loop (cdr chars)
                  (+ (* acc 10) digit))))))

  (= (+ (word->value firstWord)
        (word->value secondWord))
     (word->value targetWord)))