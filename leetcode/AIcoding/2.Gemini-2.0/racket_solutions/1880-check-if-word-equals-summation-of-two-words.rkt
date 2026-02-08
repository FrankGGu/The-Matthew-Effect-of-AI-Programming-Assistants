(define (char-to-int c)
  (- (char->integer c) (char->integer #\a)))

(define (word-to-int word)
  (string->number (list->string (map (λ (c) (number->string (char-to-int c))) (string->list word)))))

(define (is-sum-equal first-word second-word target-word)
  (= (+ (word-to-int first-word) (word-to-int second-word)) (word-to-int target-word)))