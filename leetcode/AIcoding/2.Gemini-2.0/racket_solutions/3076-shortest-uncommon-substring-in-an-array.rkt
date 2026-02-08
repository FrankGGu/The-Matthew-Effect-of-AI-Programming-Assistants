(define (shortest-uncommon-substring arr)
  (define (substrings s)
    (let loop ([i 0] [result '()])
      (if (= i (string-length s))
          result
          (loop (+ i 1) (append result (let loop2 ([j (+ i 1)])
                                           (if (> j (string-length s))
                                               '()
                                               (cons (substring s i j) (loop2 (+ j 1))))))))))

  (define (contains? s arr)
    (ormap (lambda (x) (string-contains? x s)) arr))

  (define (find-shortest-uncommon-substring arr)
    (let ([min-len 1])
      (let loop ([len min-len])
        (if (> (apply min (map string-length arr)))
            (let loop2 ([start 0])
              (if (= start (apply min (map string-length arr)))
                  ""
                  (let ([sub (substring (car arr) start (+ start 1))])
                    (if (not (contains? sub (cdr arr)))
                        sub
                        (loop2 (+ start 1))))))
            (let loop3 ([len len])
              (let loop4 ([i 0])
                (if (= i (string-length (car arr)))
                    #f
                    (let ([sub (substring (car arr) i (+ i len))])
                      (if (and (not (contains? sub (cdr arr))) (<= (+ i len) (string-length (car arr))))
                          sub
                          (if (<= (+ i len) (string-length (car arr)))
                              (loop4 (+ i 1))
                              #f)))))
              (if (loop4 0)
                  (loop4 0)
                  (if (> len (apply min (map string-length arr)))
                      ""
                      (loop3 (+ len 1)))))))))

  (let ([result (find-shortest-uncommon-substring arr)])
    (if (equal? result "")
        ""
        result)))