(define (valid-palindrome-ii s)
  (define (is-palindrome? str start end)
    (define (helper start end)
      (if (>= start end)
          #t
          (if (char=? (string-ref str start) (string-ref str end))
              (helper (add1 start) (sub1 end))
              #f)))
    (helper start end))

  (define (can-remove? start end)
    (or (is-palindrome? s (add1 start) end)
        (is-palindrome? s start (sub1 end)))
  )

  (define (check str start end)
    (if (>= start end)
        #t
        (if (char=? (string-ref str start) (string-ref str end))
            (check str (add1 start) (sub1 end))
            (can-remove? start end))))

  (check s 0 (sub1 (string-length s))))