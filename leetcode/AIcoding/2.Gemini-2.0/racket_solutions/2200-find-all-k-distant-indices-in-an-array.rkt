(define (find-k-distant-indices nums key k)
  (let* ([n (length nums)]
         [key-indices (for/list ([i (in-range n)]
                                  #:when (= (list-ref nums i) key))
                         i)]
         [result (for/list ([i (in-range n)]
                            #:when (ormap (lambda (j) (<= (abs (- i j)) k)) key-indices))
                   i)])
    result))