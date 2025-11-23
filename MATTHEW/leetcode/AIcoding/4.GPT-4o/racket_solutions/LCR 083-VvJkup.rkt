(define (permute nums)
  (define (backtrack path remaining)
    (if (null? remaining)
        (cons path '())
        (apply append
               (map (lambda (x)
                      (backtrack (cons x path) (remove x remaining)))
                    remaining))))
  (backtrack '() nums))

(define (permute-nums nums)
  (map reverse (permute nums)))