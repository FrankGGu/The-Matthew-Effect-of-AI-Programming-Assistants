(define/contract (adventure-camp expeditions)
  (-> (listof string?) exact-integer?)
  (let loop ([i 1]
             [visited (set (car expeditions))]
             [max-visits 0]
             [res -1]
             [exped (cdr expeditions)])
    (if (null? exped)
        res
        (let* ([current (car exped)]
               [camps (if (string=? current "") '() (string-split current "->"))]
               [new-camps (filter (lambda (camp) (not (set-member? visited camp))) camps)]
               [new-count (length new-camps)]
               [new-visited (foldl (lambda (camp s) (set-add s camp)) visited new-camps)]
               [new-max (if (> new-count max-visits) new-count max-visits)]
               [new-res (if (> new-count max-visits) i res)])
          (loop (add1 i) new-visited new-max new-res (cdr exped))))))