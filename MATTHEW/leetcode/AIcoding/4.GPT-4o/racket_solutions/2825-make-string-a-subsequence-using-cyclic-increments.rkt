(define (can-make-subsequence s t)
  (define (char-increment c)
    (if (= c #\z) #\a (integer->char (+ 1 (char->integer c)))))

  (define (can-form s t)
    (define (loop s t)
      (cond
        [(null? s) #t]
        [(null? t) #f]
        [else
         (if (<= (char->integer (car s)) (char->integer (car t)))
             (loop (cdr s) (cdr t))
             (loop (cdr s) t))]))
    (loop (string->list s) (string->list t)))

  (can-form s t))