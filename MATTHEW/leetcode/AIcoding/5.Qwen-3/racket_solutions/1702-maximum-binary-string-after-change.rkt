(define (max-binary-string s)
  (define (count-zeroes s)
    (let loop ([s s] [count 0])
      (if (null? s)
          count
          (loop (cdr s) (+ count (if (char=? #\0 (car s)) 1 0))))))

  (define (find-first-zero s)
    (let loop ([s s] [i 0])
      (if (null? s)
          -1
          (if (char=? #\0 (car s))
              i
              (loop (cdr s) (+ i 1))))))

  (define (build-result s first-zero zero-count)
    (let ([n (string-length s)])
      (if (>= zero-count 2)
          (let ([result (make-string n #\1)])
            (string-set! result first-zero #\0)
            (string-set! result (+ first-zero zero-count -1) #\0)
            result)
          s)))

  (let* ([n (string-length s)]
         [zero-count (count-zeroes (string->list s))]
         [first-zero (find-first-zero (string->list s))])
    (if (or (= zero-count 0) (= zero-count 1))
        s
        (build-result s first-zero zero-count))))