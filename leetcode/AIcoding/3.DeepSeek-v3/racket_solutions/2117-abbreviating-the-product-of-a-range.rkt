(define (abbreviate-product left right)
  (let* ([product (apply * (build-list (- right left -1) (lambda (x) (+ left x))))]
         [s (number->string product)]
         [len (string-length s)])
    (if (<= len 10)
        s
        (string-append (substring s 0 5) "..." (substring s (- len 5) len) "e" (number->string (- len 1))))))