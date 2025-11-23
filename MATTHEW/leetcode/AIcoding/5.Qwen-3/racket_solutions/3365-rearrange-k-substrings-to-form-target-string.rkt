(define (can-arrange s t k)
  (define (count-substrings str)
    (let ((len (string-length str)))
      (for/fold ((counts (make-hash)))
                ((i (in-range 0 (- len k + 1))))
        (let ((sub (substring str i (+ i k))))
          (hash-update counts sub add1 0)))))

  (define s-counts (count-substrings s))
  (define t-counts (count-substrings t))

  (for/and ((key (hash-keys t-counts)))
    (<= (hash-ref t-counts key 0) (hash-ref s-counts key 0))))