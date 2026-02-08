(define (check-almost-equivalent word1 word2)
  (define (count-chars s)
    (let ((counts (make-vector 26 0)))
      (for-each
       (lambda (char-code)
         (let ((idx (- char-code (char->integer #\a))))
           (vector-set! counts idx (+ (vector-ref counts idx) 1))))
       (string->list-of-char-codes s))
      counts))

  (define (string->list-of-char-codes s)
    (for/list ((c (in-string s)))
      (char->integer c)))

  (let ((counts1 (count-chars word1))
        (counts2 (count-chars word2)))
    (let loop ((i 0))
      (cond
        ((= i 26) #t)
        ((> (abs (- (vector-ref counts1 i) (vector-ref counts2 i))) 3) #f)
        (else (loop (+ i 1)))))))