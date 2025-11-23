(define (word-pattern pattern s)
  (define words (filter (lambda (w) (not (string=? w ""))) (string-split s " ")))
  (define chars (string->list pattern))

  (if (not (= (length chars) (length words)))
      #f
      (let ((char-to-word (make-hash))
            (word-to-char (make-hash)))
        (let loop ((chars-rest chars)
                   (words-rest words))
          (cond
            ((empty? chars-rest) #t)
            (else
             (define current-char (car chars-rest))
             (define current-word (car words-rest))

             (define char-has-key? (hash-has-key? char-to-word current-char))
             (define word-has-key? (hash-has-key? word-to-char current-word))

             (cond
               ((and (not char-has-key?) (not word-has-key?))
                (hash-set! char-to-word current-char current-word)
                (hash-set! word-to-char current-word current-char)
                (loop (cdr chars-rest) (cdr words-rest)))

               ((and char-has-key? word-has-key?)
                (define mapped-word (hash-ref char-to-word current-char))
                (define mapped-char (hash-ref word-to-char current-word))
                (if (and (equal? mapped-word current-word)
                         (equal? mapped-char current-char))
                    (loop (cdr chars-rest) (cdr words-rest))
                    #f))

               (else #f))))))))