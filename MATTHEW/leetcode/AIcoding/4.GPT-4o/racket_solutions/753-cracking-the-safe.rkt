(define (crackSafe(n k))
  (define (dfs path visited)
    (if (= (length path) (+ n 1))
        (begin
          (set! result (append result (list path)))
          #t)
        (for ([i (in-range 0 k)])
          (define next (string-append (substring path (- (length path) n)) (number->string i)))
          (if (not (hash-has-key? visited next))
              (begin
                (hash-set! visited next #t)
                (dfs (string-append path (number->string i)) visited)
                (hash-remove! visited next)))))
    path)

  (define result '())
  (define initial (string-append (make-string n #\0)))
  (define visited (make-hash))
  (hash-set! visited initial #t)
  (dfs initial visited)
  (define ans (string-append initial (apply string-append (reverse (map (lambda (x) (substring x n)) result)))))
  ans)

(crackSafe 2 2)