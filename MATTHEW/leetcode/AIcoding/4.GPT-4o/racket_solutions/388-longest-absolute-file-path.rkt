(define (lengthLongestPath input)
  (define (parse-line line)
    (let ([depth (length (filter (lambda (c) (equal? c #\t)) line))])
          [name (string-trim (string-replace line "\t" "") #\space)])
      (values depth name)))

  (define (dfs lines current-depth current-length)
    (if (null? lines)
        current-length
        (let-values ([(depth name) (parse-line (car lines))])
          (if (equal? depth current-depth)
              (dfs (cdr lines) current-depth (max current-length (+ (string-length name) (if (zero? current-depth) 0 1))))
              (if (> depth current-depth)
                  (dfs (cdr lines) depth (dfs (cdr lines) depth current-length))
                  (dfs (cdr lines) current-depth current-length))))))

  (dfs (string-split input "\n") 0 0))