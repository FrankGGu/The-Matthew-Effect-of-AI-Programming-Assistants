(define (takeK s k)
  (define n (string-length s))
  (define left (make-vector 26 0))
  (define right (make-vector 26 0))
  (define result "")

  (for [(i (in-range n))]
    (let* ((char (char->integer (string-ref s i)))
           (index (- char 97)))
      (vector-set! left index (add1 (vector-ref left index)))))

  (for [(i (in-range (- n 1) -1 -1))]
    (let* ((char (char->integer (string-ref s i)))
           (index (- char 97)))
      (vector-set! right index (add1 (vector-ref right index)))))

  (for [(i (in-range n))]
    (let* ((char (string-ref s i))
           (index (- (char->integer char) 97)))
      (when (and (<= (vector-ref left index) k) (<= (vector-ref right index) k))
        (set! result (string-append result (string char)))
        (vector-set! left index (add1 (vector-ref left index)))
        (vector-set! right index (sub1 (vector-ref right index))))))

  result)