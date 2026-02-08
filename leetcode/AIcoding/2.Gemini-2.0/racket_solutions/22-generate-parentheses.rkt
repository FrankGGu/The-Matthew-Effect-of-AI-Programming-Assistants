(define (generate-parenthesis n)
  (define (generate-combinations open close current)
    (cond
      [(= open n) (list (string-append current (make-string (- n close) #\))))]
      [(= close n) '()]
      [else
       (append
        (if (< open n) (generate-combinations (+ open 1) close (string-append current "(")) '())
        (if (< close open) (generate-combinations open (+ close 1) (string-append current ")")) '()))]))
  (generate-combinations 0 0 ""))