(define (majority-element nums)
  (define (count-occurrences num lst)
    (length (filter (lambda (x) (equal? x num)) lst)))

  (let ([threshold (floor (/ (length nums) 3))])
    (let loop ([candidates '()] [remaining nums])
      (cond
        [(null? remaining)
         (filter (lambda (x) (> (count-occurrences x nums) threshold)) candidates)]
        [else
         (let ([candidate (car remaining)])
           (if (member candidate candidates)
               (loop candidates (cdr remaining))
               (if (<= (length candidates) 1)
                   (loop (cons candidate candidates) (cdr remaining))
                   (loop (cdr candidates) (cdr remaining)))))]))))