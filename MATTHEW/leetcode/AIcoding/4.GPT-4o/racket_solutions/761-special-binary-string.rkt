(define (make-special-binary-string S)
  (if (null? S)
      ""
      (let* ([count (count (lambda (x) (equal? x #\1)) S)]
             [left (filter (lambda (x) (equal? x #\1)) S)]
             [right (filter (lambda (x) (equal? x #\0)) S)]
             [result (apply string-append (cons (string-append (make-special-binary-string (take S count))
                                                               (string-append "1" (make-special-binary-string (take-right S (- (length S) count)))))
                                                (map (lambda (x) (string x)) right)))]))
        result)))

(define (special-binary-string S)
  (make-special-binary-string (string->list S)))

(define (make-special-binary-string-main S)
  (list->string (special-binary-string S)))

(define (main)
  (make-special-binary-string-main "11011000"))