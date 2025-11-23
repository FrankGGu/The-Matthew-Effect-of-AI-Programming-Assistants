(define (canMakePaliQueries s queries)
  (define (char-count str)
    (foldl (lambda (c acc)
              (vector-set! acc (char->integer c) (+ 1 (vector-ref acc (char->integer c)))))
            (make-vector 26 0)
            str))

  (define (is-palindrome-count? count odd)
    (define odd-count (foldl (lambda (x acc)
                                (+ acc (if (odd? x) 1 0)))
                              0
                              count))
    (<= odd-count odd))

  (define prefix-count (list->vector (map char-count (list ""))))

  (for ([i (in-range (string-length s))])
    (let ([count (vector-copy (vector-ref prefix-count i))])
      (vector-set! prefix-count (add1 i) count)
      (for ([j (in-range (add1 i) (string-length s))])
        (let ([substr (substring s i (add1 j))])
          (define sub-count (char-count substr))
          (vector-set! prefix-count (add1 j) sub-count)))))

  (map (lambda (query)
         (let ([start (car query)]
               [end (cadr query)]
               [odd (caddr query)])
           (is-palindrome-count? (vector-ref prefix-count (add1 end)) odd)))
       queries))