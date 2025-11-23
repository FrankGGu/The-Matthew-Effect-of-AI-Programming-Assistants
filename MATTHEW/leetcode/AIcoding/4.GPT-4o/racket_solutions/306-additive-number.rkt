(define (is-additive-number s)
  (define (is-valid a b c)
    (let loop ((a a) (b b) (c c))
      (if (string=? c "")
          (string=? (number->string (+ (string->number a) (string->number b))) "")
          (let ((sum (number->string (+ (string->number a) (string->number b)))))
            (if (string-prefix? c sum)
                (loop b (substring c 0 (string-length sum)) (substring c (string-length sum)))
                #f)))))

  (define (check-length i j)
    (let ((a (substring s 0 i))
          (b (substring s i j))
          (c (substring s j)))
      (if (or (string=? a "") (string=? b "") (string=? c ""))
          #f
          (is-valid a b c))))

  (define (find-additive-number i j)
    (if (>= i (string-length s))
        #f
        (if (>= j (string-length s))
            (find-additive-number (+ i 1) (+ i 2))
            (if (check-length i j)
                #t
                (find-additive-number i (+ j 1))))))

  (find-additive-number 1 2))

(define (isAdditiveNumber s)
  (is-additive-number s))