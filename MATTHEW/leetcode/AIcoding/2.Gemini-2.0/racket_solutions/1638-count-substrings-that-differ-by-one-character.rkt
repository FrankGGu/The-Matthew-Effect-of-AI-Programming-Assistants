(define (count-substrings s t)
  (define (diff-by-one? s-sub t-sub)
    (let loop ([s-chars (string->list s-sub)]
               [t-chars (string->list t-sub)]
               [diff-count 0])
      (cond
        [(empty? s-chars) (= diff-count 1)]
        [(> diff-count 1) #f]
        [else (if (char=? (car s-chars) (car t-chars))
                  (loop (cdr s-chars) (cdr t-chars) diff-count)
                  (loop (cdr s-chars) (cdr t-chars) (+ diff-count 1)))])))

  (define n (string-length s))
  (define m (string-length t))
  (let loop ([i 0]
             [count 0])
    (if (= i n)
        count
        (let loop2 ([j 0])
          (if (= j m)
              (loop (+ i 1) count)
              (let loop3 ([len 1])
                (if (or (> (+ i len -1) (- n 1)) (> (+ j len -1) (- m 1)))
                    (loop2 (+ j 1))
                    (let ([s-sub (substring s i (+ i len))]
                          [t-sub (substring t j (+ j len))])
                      (if (diff-by-one? s-sub t-sub)
                          (loop3 (+ len 1) (+ count 1))
                          (loop3 (+ len 1) count)))))))))