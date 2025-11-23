(define (find-maximum-number-of-non-intersecting-substrings s)
  (define n (string-length s))

  (define left (make-vector 26 -1))
  (define right (make-vector 26 -1))

  (for ([k (in-range n)])
    (define char-idx (- (char->integer (string-ref s k)) (char->integer #\a)))
    (when (= (vector-ref left char-idx) -1)
      (vector-set! left char-idx k))
    (vector-set! right char-idx k))

  (define valid-substrings '())

  (for ([i (in-range n)])
    (define char-i-idx (- (char->integer (string-ref s i)) (char->integer #\a)))

    (when (= (vector-ref left char-i-idx) i)
      (define current-max-right (vector-ref right char-i-idx))
      (define is-valid-start #t)
      (define k i)

      (let loop ()
        (when (and is-valid-start (<= k current-max-right))
          (define char-k-idx (- (char->integer (string-ref s k)) (char->integer #\a)))

          (when (< (vector-ref left char-k-idx) i)
            (set! is-valid-start #f))

          (set! current-max-right (max current-max-right (vector-ref right char-k-idx)))
          (set! k (add1 k))
          (loop)))

      (when is-valid-start
        (set! valid-substrings (cons (cons i current-max-right) valid-substrings)))))

  (define sorted-substrings (sort valid-substrings
                                  (lambda (a b)
                                    (let ([end-a (cdr a)]
                                          [end-b (cdr b)])
                                      (if (= end-a end-b)
                                          (< (car a) (car b))
                                          (< end-a end-b))))))

  (define result '())
  (define prev-end -1)

  (for ([sub-pair sorted-substrings])
    (define start (car sub-pair))
    (define end (cdr sub-pair))

    (when (> start prev-end)
      (set! result (cons (substring s start (add1 end)) result))
      (set! prev-end end)))

  (reverse result))