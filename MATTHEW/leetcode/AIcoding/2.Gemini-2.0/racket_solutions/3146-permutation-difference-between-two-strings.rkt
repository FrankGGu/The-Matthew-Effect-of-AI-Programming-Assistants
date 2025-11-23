(define (permutation-difference s1 s2)
  (define (char-counts str)
    (define counts (make-hash))
    (for ([c (in-string str)])
      (hash-update! counts c add1 0))
    counts)

  (define counts1 (char-counts s1))
  (define counts2 (char-counts s2))

  (define diff 0)
  (hash-for-each counts1
                 (lambda (c count1)
                   (define count2 (hash-ref counts2 c 0))
                   (set! diff (+ diff (abs (- count1 count2))))))

  diff)