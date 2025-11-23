(define (minimum-length-encoding words)
  (define (suffix? s t)
    (and (>= (string-length t) (string-length s))
         (string=? s (substring t (- (string-length t) (string-length s)) (string-length t)))))

  (define (solve words)
    (define sorted-words (sort words string>?))
    (define (iter lst acc)
      (cond
        [(empty? lst) acc]
        [else
         (let* ([current (car lst)]
                [rest (cdr lst)]
                [is-suffix (ormap (lambda (word) (suffix? current word)) rest)])
           (if is-suffix
               (iter rest acc)
               (iter rest (+ acc (string-length current) 1))))]))
    (iter sorted-words 0))

  (solve words))