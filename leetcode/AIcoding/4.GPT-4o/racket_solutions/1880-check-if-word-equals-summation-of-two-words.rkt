(define (is-sum-equal first second target)
  (define (word-to-number word)
    (foldl (lambda (char acc)
             (+ (* acc 10) (- (char->integer char) (char->integer #\a))))
           0
           word))
  (= (+ (word-to-number first) (word-to-number second))
     (word-to-number target)))