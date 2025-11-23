(define (largest-number nums)
  (define (comparator a b)
    (string>? (string-append a b) (string-append b a)))

  (let* ([strs (map number->string nums)]
         [sorted-strs (sort strs comparator)])
    (let ([result (string-join (reverse sorted-strs) "")])
      (if (string=? result (make-string (string-length result) #\0))
          "0"
          result))))