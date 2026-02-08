(define (remove-invalid-parentheses s)
  (define (is-valid? str)
    (let loop ([str (string->list str)]
               [balance 0])
      (cond
        [(empty? str) (= balance 0)]
        [(negative? balance) #f]
        [else
         (let ([c (car str)])
           (cond
             [(char=? c #\() (loop (cdr str) (+ balance 1))]
             [(char=? c #\)) (loop (cdr str) (- balance 1))]
             [else (loop (cdr str) balance)]))]))
    )

  (define (bfs s)
    (let ([q (list s)]
          [visited (make-hash)])
      (hash-set! visited s #t)
      (let loop ([q q] [result '()])
        (cond
          [(empty? q) result]
          [else
           (let ([curr (car q)])
             (cond
               [(is-valid? curr) (loop (cdr q) (cons curr result))]
               [else
                (let ([next-level
                       (foldr
                        (lambda (i acc)
                          (let ([next-str (string-append (substring curr 0 i) (substring curr (+ i 1) (string-length curr)))])
                            (if (hash-ref visited next-str #f)
                                acc
                                (begin
                                  (hash-set! visited next-str #t)
                                  (cons next-str acc)))))
                        '()
                        (range 0 (string-length curr)))]
                  (loop (append (cdr q) next-level) result))]))]))))
    )

  (let ([result (bfs s)])
    (if (empty? result)
        (let ([min-len (apply min (map string-length result))])
          (list (string-append "")))
        (let ([max-len (apply max (map string-length result))])
          (remove-duplicates
           (filter (lambda (s) (= (string-length s) max-len)) result)
           string=?))))
  )