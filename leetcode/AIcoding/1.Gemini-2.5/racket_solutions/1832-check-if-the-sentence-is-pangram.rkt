(define/contract (check-if-pangram sentence)
  (string? -> boolean?)
  (let ((seen-letters (set)))
    (for-each
     (lambda (char)
       (set! seen-letters (set-add seen-letters char)))
     (string->list sentence))
    (= (set-count seen-letters) 26)))