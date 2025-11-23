(define (find-beautiful-indices s a b k)
  (define n (string-length s))
  (define m_a (string-length a))
  (define m_b (string-length b))

  (define indices_a '())
  (define indices_b '())

  (for ([i (in-range (- n m_a) 1)])
    (when (string=? (substring s (- n i) (+ (- n i) m_a)) a)
      (set! indices_a (cons (- n i) indices_a))))

  (for ([i (in-range (- n m_b) 1)])
    (when (string=? (substring s (- n i) (+ (- n i) m_b)) b)
      (set! indices_b (cons (- n i) indices_b))))

  (define beautiful_indices '())
  (for ([i (in-list indices_a)])
    (define found #f)
    (for ([j (in-list indices_b)])
      (when (<= (abs (- i j)) k)
        (set! found #t)
        (break)))
    (when found
      (set! beautiful_indices (cons i beautiful_indices))))

  (sort (remove-duplicates beautiful_indices) <))