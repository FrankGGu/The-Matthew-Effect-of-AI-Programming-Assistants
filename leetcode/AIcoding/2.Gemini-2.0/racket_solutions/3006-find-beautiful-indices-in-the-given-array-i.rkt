(define (beautiful-indices s a b k)
  (define n (string-length s))
  (define indices-a (list))
  (define indices-b (list))

  (for ([i (in-range n)])
    (when (string=? (substring s i (+ i (string-length a))) a)
      (set! indices-a (cons i indices-a))))

  (for ([i (in-range n)])
    (when (string=? (substring s i (+ i (string-length b))) b)
      (set! indices-b (cons i indices-b))))

  (define result (list))
  (for ([i (in-list indices-a)])
    (define found #f)
    (for ([j (in-list indices-b)])
      (when (<= (abs (- i j)) k)
        (set! found #t)
        (break)))
    (when found
      (set! result (cons i result))))

  (sort result <))