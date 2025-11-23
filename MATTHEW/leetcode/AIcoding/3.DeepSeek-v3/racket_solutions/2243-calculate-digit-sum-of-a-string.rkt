(define (digit-sum s k)
  (let loop ([s s])
    (if (<= (string-length s) k)
        s
        (let* ([groups (group-string s k)]
               [new-s (apply string-append (map sum-group groups))])
          (loop new-s)))))

(define (group-string s k)
  (let loop ([s s] [res '()])
    (if (string=? s "")
        (reverse res)
        (let-values ([(group rest) (split-at s (min k (string-length s)))])
          (loop rest (cons group res))))))

(define (sum-group group)
  (number->string
   (apply + (map (lambda (c) (- (char->integer c) (char->integer #\0)))
                 (string->list group)))))

(define (split-at s n)
  (values (substring s 0 n) (substring s n)))