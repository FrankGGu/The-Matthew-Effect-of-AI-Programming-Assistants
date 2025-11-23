(define (concatenated-words words)
  (define word-set (make-hash))
  (for-each (lambda (word) (hash-set! word-set word #t)) words)

  (define (can-form? word)
    (define len (string-length word))
    (define dp (make-vector (add1 len) #f))
    (vector-set! dp 0 #t)

    (for ([i (in-range 1 (add1 len))])
      (for ([j (in-range 0 i)])
        (when (and (vector-ref dp j)
                   (hash-ref word-set (substring word j i) #f))
          (vector-set! dp i #t)
          (break))))

    (and (vector-ref dp len) (> len 0)))

  (filter can-form? (sort words string<?)))