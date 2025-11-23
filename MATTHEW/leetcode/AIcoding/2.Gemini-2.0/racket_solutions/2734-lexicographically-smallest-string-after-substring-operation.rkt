(define (smallest-string s)
  (let loop ([i 0] [found-a #f] [res '()])
    (if (= i (string-length s))
        (list->string (reverse res))
        (let ([c (string-ref s i)])
          (cond
            [(and (not found-a) (char<? c #\a))
             (loop (+ i 1) found-a (cons c res))]
            [(and (not found-a) (char=? c #\a))
             (loop (+ i 1) found-a (cons c res))]
            [(and (not found-a) (char>? c #\a))
             (let loop2 ([j i] [res2 '()])
               (if (= j (string-length s))
                   (list->string (reverse (append (reverse res) res2)))
                   (let ([c2 (string-ref s j)])
                     (if (char=? c2 #\a)
                         (list->string (reverse (append (reverse res) res2 (string->list (substring s j (string-length s))))))
                         (loop2 (+ j 1) (cons (integer->char (- (char->integer c2) 1)) res2))))))]
            [else
             (loop (+ i 1) found-a (cons c res))])))))