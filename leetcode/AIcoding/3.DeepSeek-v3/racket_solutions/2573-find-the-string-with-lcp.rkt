(define (find-the-string lcp)
  (define n (vector-length lcp))
  (when (or (zero? n) (not (equal? (vector-length (vector-ref lcp 0)) n)))
    (return ""))

  (define res (make-vector n #\a))
  (define (valid? i j)
    (if (>= j n)
        #t
        (let ([val (vector-ref (vector-ref lcp i) j)])
          (cond
            [(< val 0) #f]
            [(> (+ val i) n) #f]
            [(= i j) (if (not (= val (- n i))) #f (valid? i (add1 j)))]
            [else
             (define k val
             (cond
               [(zero? k) (if (eq? (vector-ref res i) (vector-ref res j))
                               (valid? i (add1 j))
                               #f)]
               [(> k 0) (if (and (eq? (vector-ref res i) (vector-ref res j))
                                 (valid? (add1 i) (add1 j)))
                          (valid? i (add1 j))
                          #f)]
               [else #f])])))))

  (for ([i (in-range n)])
    (when (char=? (vector-ref res i) #\a)
      (for ([j (in-range i n)])
        (when (positive? (vector-ref (vector-ref lcp i) j))
          (vector-set! res j (vector-ref res i)))))

  (if (valid? 0 0)
      (list->string (vector->list res))
      ""))