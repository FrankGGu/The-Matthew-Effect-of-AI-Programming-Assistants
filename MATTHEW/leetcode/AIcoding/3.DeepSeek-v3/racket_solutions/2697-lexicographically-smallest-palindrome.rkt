(define (make-smallest-palindrome s)
  (let* ([n (string-length s)]
         [s-list (string->list s)]
         [left 0]
         [right (- n 1)])
    (let loop ([left left] [right right] [s-list s-list])
      (if (>= left right)
          (list->string s-list)
          (let ([left-char (list-ref s-list left)]
                [right-char (list-ref s-list right)])
            (if (char>? left-char right-char)
                (loop left right (list-set s-list left right-char))
                (loop left right (list-set s-list right left-char))))))))