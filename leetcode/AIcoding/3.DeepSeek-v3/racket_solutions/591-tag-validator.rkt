(define (is-valid code)
  (let loop ([i 0] [stack '()])
    (cond
      [(>= i (string-length code)) (null? stack)]
      [(and (< (+ i 8) (string-length code)) (string=? (substring code i (+ i 9)) "<![CDATA["))
       (let ([j (string-index-of code "]]>" i)])
         (if j (loop (+ j 3) stack) #f))]
      [(and (< (+ i 1) (string-length code)) (char=? (string-ref code i) #\<))
       (if (char=? (string-ref code (+ i 1)) #\/)
           (let ([j (string-index-of code #\> (+ i 2))])
             (if (and j (not (null? stack)) 
                 (let ([tag (substring code (+ i 2) j)])
                   (if (string=? tag (car stack))
                       (loop (+ j 1) (cdr stack))
                       #f))
                 #f))
           (let ([j (string-index-of code #\> (+ i 1))])
             (if (and j (> (- j i 1) 0) (< (- j i 1) 10))
                 (let ([tag (substring code (+ i 1) j)])
                   (if (and (for/and ([c tag]) (char-upper-case? c))
                       (loop (+ j 1) (cons tag stack))
                       #f))
                 #f)))]
      [else (loop (+ i 1) stack)])))