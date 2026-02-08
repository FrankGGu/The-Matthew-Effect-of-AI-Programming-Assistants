(define (largest-word-count messages senders)
  (let* ([sender-word-count (make-hash)]
         [max-count 0]
         [result ""])
    (for ([message messages]
          [sender senders])
      (let ([count (length (string-split message))])
        (hash-update! sender-word-count sender 
                      (lambda (val) (+ val count)) 
                      (lambda () count)))
    (for ([(sender count) (in-hash sender-word-count)])
      (cond
        [(> count max-count)
         (set! max-count count)
         (set! result sender)]
        [(= count max-count)
         (when (string>? sender result)
           (set! result sender))]))
    result))