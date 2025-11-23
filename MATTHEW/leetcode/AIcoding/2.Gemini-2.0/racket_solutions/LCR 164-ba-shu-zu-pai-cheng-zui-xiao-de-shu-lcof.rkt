(define (crack-the-safe n k)
  (let* ([total-combinations (expt k n)]
         [visited (make-hash)]
         [res (make-string n #\0)])
    (hash-set! visited (substring res 0 n) #t)
    (letrec ([dfs (lambda (current)
                      (when (= (hash-count visited) total-combinations)
                        (void))
                      (for/first ([i (in-range (sub1 k) -1 -1)])
                        (let* ([next-string (string-append (substring current 1 n) (number->string i))]
                               [found (hash-ref visited next-string #f)])
                          (unless found
                            (begin
                              (hash-set! visited next-string #t)
                              (string-set! res (+ (string-length res) n -1) (string->list (number->string i)) 0)
                              (dfs next-string)
                              (unless (= (hash-count visited) total-combinations)
                                (hash-remove! visited next-string)
                                (string-set! res (+ (string-length res) n -1) #\0))))))))])
      (dfs res)
      res)))