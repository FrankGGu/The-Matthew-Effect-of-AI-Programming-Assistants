(define (digit-sum s k)
  (define (process str)
    (if (<= (string-length str) k)
        str
        (let loop ((i 0) (acc '()) (current ""))
          (if (= i (string-length str))
              (string-join (map (λ (s) (number->string (string->number s))) acc) "")
              (let ((new-current (string-append current (substring str i (+ i 1)))))
                (if (= (string-length new-current) k)
                    (loop (+ i 1) (append acc (list new-current)) "")
                    (loop (+ i 1) acc new-current)))))))

  (let loop ((str s))
    (if (<= (string-length str) k)
        str
        (loop (process str)))))