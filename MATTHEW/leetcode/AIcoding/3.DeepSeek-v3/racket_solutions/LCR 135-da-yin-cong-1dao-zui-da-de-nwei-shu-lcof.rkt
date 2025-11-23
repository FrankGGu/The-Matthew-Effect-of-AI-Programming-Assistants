(define (count-and-say n)
  (define (next s)
    (let loop ([s s] [res '()] [count 0] [prev #f])
      (cond
        [(null? s)
         (if prev
             (reverse (cons (integer->char (+ (char->integer #\0) count)) (cons prev res)))
             (reverse res))]
        [(not prev) (loop (cdr s) res 1 (car s))]
        [(equal? (car s) prev) (loop (cdr s) res (add1 count) prev)]
        [else (loop s (cons prev (cons (integer->char (+ (char->integer #\0) count)) res)) 0 #f)])))

  (let loop ([i 1] [current "1"])
    (if (= i n)
        current
        (loop (add1 i) (list->string (next (string->list current))))))