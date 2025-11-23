(define (original-digits s)
  (define counts (make-hash '()))
  (for ([c (string->list s)])
    (hash-update! counts c add1 0))

  (define digits (make-vector 10 0))

  (vector-set! digits 0 (hash-ref counts #\z 0))
  (hash-update! counts #\z - (vector-ref digits 0))
  (hash-update! counts #\e - (vector-ref digits 0))
  (hash-update! counts #\r - (vector-ref digits 0))
  (hash-update! counts #\o - (vector-ref digits 0))

  (vector-set! digits 2 (hash-ref counts #\w 0))
  (hash-update! counts #\t - (vector-ref digits 2))
  (hash-update! counts #\w - (vector-ref digits 2))
  (hash-update! counts #\o - (vector-ref digits 2))

  (vector-set! digits 4 (hash-ref counts #\u 0))
  (hash-update! counts #\f - (vector-ref digits 4))
  (hash-update! counts #\o - (vector-ref digits 4))
  (hash-update! counts #\u - (vector-ref digits 4))
  (hash-update! counts #\r - (vector-ref digits 4))

  (vector-set! digits 6 (hash-ref counts #\x 0))
  (hash-update! counts #\s - (vector-ref digits 6))
  (hash-update! counts #\i - (vector-ref digits 6))
  (hash-update! counts #\x - (vector-ref digits 6))

  (vector-set! digits 8 (hash-ref counts #\g 0))
  (hash-update! counts #\e - (vector-ref digits 8))
  (hash-update! counts #\i - (vector-ref digits 8))
  (hash-update! counts #\g - (vector-ref digits 8))
  (hash-update! counts #\h - (vector-ref digits 8))
  (hash-update! counts #\t - (vector-ref digits 2))

  (vector-set! digits 1 (hash-ref counts #\o 0))
  (hash-update! counts #\o - (vector-ref digits 1))
  (hash-update! counts #\n - (vector-ref digits 1))
  (hash-update! counts #\e - (vector-ref digits 1))

  (vector-set! digits 3 (hash-ref counts #\h 0))
  (hash-update! counts #\t - (vector-ref digits 3))
  (hash-update! counts #\h - (vector-ref digits 3))
  (hash-update! counts #\r - (vector-ref digits 3))
  (hash-update! counts #\e - (vector-ref digits 3))
  (hash-update! counts #\e - (vector-ref digits 3))

  (vector-set! digits 5 (hash-ref counts #\f 0))
  (hash-update! counts #\f - (vector-ref digits 5))
  (hash-update! counts #\i - (vector-ref digits 5))
  (hash-update! counts #\v - (vector-ref digits 5))
  (hash-update! counts #\e - (vector-ref digits 5))

  (vector-set! digits 7 (hash-ref counts #\s 0))
  (hash-update! counts #\s - (vector-ref digits 7))
  (hash-update! counts #\e - (vector-ref digits 7))
  (hash-update! counts #\v - (vector-ref digits 5))
  (hash-update! counts #\e - (vector-ref digits 7))
  (hash-update! counts #\n - (vector-ref digits 7))

  (vector-set! digits 9 (hash-ref counts #\i 0))

  (let loop ([i 0] [res ""])
    (if (= i 10)
        res
        (loop (+ i 1) (string-append res (make-string (vector-ref digits i) (number->string i)))))
  )
)