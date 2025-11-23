(define (max-score s)
  (define n (string-length s))
  (define (count-zeros sub)
    (count (lambda (c) (char=? c #\0)) (string->list sub)))
  (define (count-ones sub)
    (count (lambda (c) (char=? c #\1)) (string->list sub)))

  (let loop ([i 1] [max-so-far 0])
    (if (= i n)
        max-so-far
        (let ([left (substring s 0 i)]
              [right (substring s i n)])
          (loop (+ i 1) (max max-so-far (+ (count-zeros left) (count-ones right))))))))