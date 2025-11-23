(define (find-beautiful-string s)
  (define (is-beautiful? s)
    (let loop ((i 0))
      (cond ((>= i (- (string-length s) 1)) #t)
            ((char=? (string-ref s i) (string-ref s (+ i 1))) #f)
            (else (loop (+ i 1))))))

  (define (next-string s)
    (let ((chars (string->list s)))
      (let loop ((i (- (length chars) 1)))
        (if (< i 0)
            #f
            (let ((c (char->integer (list-ref chars i))))
              (if (< c 122)
                  (list->string (append (take chars i)
                                       (list (integer->char (+ c 1)))
                                       (make-list (- (length chars) i 1) #\a)))
                  (loop (- i 1))))))))

  (let loop ((s s))
    (if (is-beautiful? s)
        s
        (loop (next-string s)))))