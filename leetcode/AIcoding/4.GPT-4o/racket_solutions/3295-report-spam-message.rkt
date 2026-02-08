(define (reportSpam messages)
  (map (lambda (msg) (if (string-contains? msg "spam") 1 0)) messages))