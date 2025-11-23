(define (compress chars)
  (let loop ([i 0] [j 0] [count 1])
    (cond
      [(>= i (length chars)) j]
      [(= i (- (length chars) 1))
       (vector-set! chars j (list-ref chars i))
       (set! j (+ j 1))
       (if (> count 1)
           (let ([count-str (number->string count)])
             (for ([k (in-range (string-length count-str))])
               (vector-set! chars j (string-ref count-str k))
               (set! j (+ j 1))))
           #t)
       j]
      [(= (list-ref chars i) (list-ref chars (+ i 1)))
       (loop (+ i 1) j (+ count 1))]
      [else
       (vector-set! chars j (list-ref chars i))
       (set! j (+ j 1))
       (if (> count 1)
           (let ([count-str (number->string count)])
             (for ([k (in-range (string-length count-str))])
               (vector-set! chars j (string-ref count-str k))
               (set! j (+ j 1))))
           #t)
       (loop (+ i 1) j 1)])))