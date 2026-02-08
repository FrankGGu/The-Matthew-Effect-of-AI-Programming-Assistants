(define (palindrome? s)
  (let ((len (string-length s)))
    (if (<= len 1)
        #t
        (let loop ((i 0)
                   (j (- len 1)))
          (if (>= i j)
              #t
              (if (char=? (string-ref s i) (string-ref s j))
                  (loop (+ i 1) (- j 1))
                  #f))))))

(define (first-palindrome words)
  (if (empty? words)
      ""
      (let loop ((word-list words))
        (if (empty? word-list)
            ""
            (let ((current-word (car word-list)))
              (if (palindrome? current-word)
                  current-word
                  (loop (cdr word-list))))))))