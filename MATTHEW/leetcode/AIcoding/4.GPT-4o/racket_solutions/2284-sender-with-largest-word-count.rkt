(define (most-words messages)
  (define (count-words message)
    (length (filter (lambda (x) (not (string-empty? x))) (string-split message))))
  (define (helper messages max-count max-sender)
    (cond
      [(null? messages) max-sender]
      [else
       (let* ([current-message (car messages)]
              [current-sender (car (string-split current-message ": "))]
              [current-count (count-words (cadr (string-split current-message ": ")))]
              [new-max-sender (if (> current-count max-count) current-sender current-sender)]
              [new-max-count (max current-count max-count)])
         (helper (cdr messages) new-max-count new-max-sender)))])
  (helper messages 0 ""))

(most-words '("Alice: Hello World" "Bob: Hi there" "Alice: How are you doing?"))