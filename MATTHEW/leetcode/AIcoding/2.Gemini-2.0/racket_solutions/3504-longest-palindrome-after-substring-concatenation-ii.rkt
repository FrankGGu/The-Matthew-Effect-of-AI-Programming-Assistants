(define (longest-palindrome-after-substring-concatenation II s)
  (define (is-palindrome? str)
    (equal? str (list->string (reverse (string->list str)))))

  (define (solve s)
    (define n (string-length s))
    (define (find-longest-palindrome start end)
      (cond
        [(< end start) ""]
        [(= end start) (string (string-ref s start))]
        [else
         (let ([s1 (substring s start (+ end 1))])
           (if (is-palindrome? s1)
               s1
               (let ([s2 (find-longest-palindrome start (- end 1))]
                     [s3 (find-longest-palindrome (+ start 1) end)])
                 (if (> (string-length s2) (string-length s3))
                     s2
                     s3))))]))

    (find-longest-palindrome 0 (- n 1)))

  (let ([n (vector-length s)])
    (let loop ([i 0] [max-len 0])
      (if (= i n)
          max-len
          (let loop2 ([j (+ i 1)] [curr-max-len max-len])
            (if (= j n)
                (loop (+ i 1) curr-max-len)
                (let ([combined-string (string-append (vector-ref s i) (vector-ref s j))])
                  (let ([longest-palindrome (solve combined-string)])
                    (loop2 (+ j 1) (max curr-max-len (string-length longest-palindrome)))))))))))