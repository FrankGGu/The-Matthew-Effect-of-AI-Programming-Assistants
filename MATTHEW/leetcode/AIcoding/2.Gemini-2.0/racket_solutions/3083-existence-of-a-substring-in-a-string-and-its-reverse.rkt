(define (solve s sub)
  (let* ([n (string-length s)]
         [m (string-length sub)]
         [rev-sub (string-reverse sub)])
    (letrec ([helper (lambda (i)
                       (cond
                         [(>= i (- n m -1)) #f]
                         [(string=? (substring s i (+ i m)) sub) #t]
                         [(string=? (substring s i (+ i m)) rev-sub) #t]
                         [else (helper (+ i 1))]))])
      (helper 0))))

(define (string-existence s sub)
  (solve s sub))