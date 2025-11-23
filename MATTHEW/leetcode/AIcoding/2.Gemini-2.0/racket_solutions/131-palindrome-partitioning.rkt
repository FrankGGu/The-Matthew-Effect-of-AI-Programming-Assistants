(define (partition s)
  (define (is-palindrome? str)
    (equal? str (string-reverse str)))

  (define (helper str current-partition partitions)
    (cond
      [(string=? str "")
       (cons (reverse current-partition) partitions)]
      [else
       (let loop ([i 1])
         (cond
           [(> i (string-length str)) partitions]
           [else
            (let* ([prefix (substring str 0 i)]
                   [suffix (substring str i (string-length str))])
              (if (is-palindrome? prefix)
                  (loop (+ i 1) )
                  (loop (+ i 1))))
           (if (is-palindrome? (substring str 0 i))
                  (helper (substring str i (string-length str)) (cons prefix current-partition) partitions)
                  partitions))
         (let ([prefix (substring str 0 i)]
               [suffix (substring str i (string-length str))])
           (if (is-palindrome? prefix)
               (helper suffix (cons prefix current-partition) partitions)
               partitions))]

          (let loop ([i 1] [new-partitions partitions])
            (if (> i (string-length str))
                new-partitions
                (let* ([prefix (substring str 0 i)]
                       [suffix (substring str i (string-length str))])
                  (if (is-palindrome? prefix)
                      (loop (+ i 1) (helper suffix (cons prefix current-partition) new-partitions))
                      (loop (+ i 1) new-partitions))))))))
  (helper s '() '()))