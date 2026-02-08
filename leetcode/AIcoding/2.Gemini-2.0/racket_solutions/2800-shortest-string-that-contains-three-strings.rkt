(define (shortest-superstring s1 s2 s3)
  (define (overlap a b)
    (let loop ([i (min (string-length a) (string-length b))])
      (cond
        [(= i 0) 0]
        [(string=? (substring a (- (string-length a) i) (string-length a)) (substring b 0 i)) i]
        [else (loop (- i 1))])))

  (define (merge a b)
    (let ([o (overlap a b)])
      (string-append a (substring b o (string-length b)))))

  (define (permute lst)
    (if (null? lst)
        '(())
        (apply append
               (map (lambda (x)
                      (map (lambda (y) (cons x y))
                           (permute (remove x lst))))
                    lst))))

  (define (solve a b c)
    (merge (merge a b) c))

  (define (shortest lst)
    (foldl (lambda (x acc) (if (< (string-length x) (string-length acc)) x acc)) (car lst) lst))

  (shortest (map (lambda (p) (solve (list-ref p 0) (list-ref p 1) (list-ref p 2))) (permute (list s1 s2 s3)))))