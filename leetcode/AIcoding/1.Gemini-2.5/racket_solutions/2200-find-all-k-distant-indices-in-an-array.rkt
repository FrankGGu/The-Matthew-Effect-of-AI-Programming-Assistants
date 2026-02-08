(define (find-all-k-distant-indices nums key k)
  (let* ((n (vector-length nums))
         (key-indices
          (for/list ([j (in-range n)]
                     #:when (= (vector-ref nums j) key))
            j)))
    (for/list ([i (in-range n)]
               #:when (ormap (lambda (j) (<= (abs (- i j)) k))
                             key-indices))
      i)))