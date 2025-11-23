(define (digit-sum s k)
  (define (sum-string str)
    (apply + (map (lambda (c) (- (char->integer c) (char->integer #\0))) str)))

  (define (reduce-string str k)
    (if (<= (string-length str) k)
        str
        (let loop ((chunks (map (lambda (i) (substring str i (min (string-length str) (+ i k)))) (range 0 (string-length str) k)))
                   (result ""))
          (if (null? chunks)
              result
              (loop (cdr chunks) (string-append result (number->string (sum-string (car chunks)))))))))

  (reduce-string s k))