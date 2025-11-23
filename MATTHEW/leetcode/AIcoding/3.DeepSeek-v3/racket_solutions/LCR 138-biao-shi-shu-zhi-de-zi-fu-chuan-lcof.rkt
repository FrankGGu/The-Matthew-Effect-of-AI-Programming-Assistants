(define (isNumber s)
  (define (char->digit c)
    (- (char->integer c) (char->integer #\0)))

  (define (digit? c)
    (and (char<=? #\0 c) (char<=? c #\9)))

  (define (sign? c)
    (or (char=? c #\+) (char=? c #\-)))

  (define (parse-integer s start)
    (let loop ([i start] [has-digit #f])
      (cond
        [(>= i (string-length s)) has-digit]
        [(digit? (string-ref s i)) (loop (add1 i) #t)]
        [else #f])))

  (define (parse-decimal s start)
    (let loop ([i start] [has-digit #f] [has-dot #f])
      (cond
        [(>= i (string-length s)) has-digit]
        [(digit? (string-ref s i)) (loop (add1 i) #t has-dot)]
        [(and (char=? (string-ref s i) #\.) (not has-dot)) (loop (add1 i) has-digit #t)]
        [else #f])))

  (define (parse-exponent s start)
    (and (< start (string-length s))
         (let ([i (if (sign? (string-ref s start)) (add1 start) start)])
           (and (< i (string-length s))
                (parse-integer s i)))))

  (let* ([s (string-trim s)]
         [n (string-length s)]
         [i 0])
    (cond
      [(zero? n) #f]
      [else
       (let* ([i (if (sign? (string-ref s i)) (add1 i) i)]
              [decimal? (parse-decimal s i)]
              [exponent? #f])
         (when decimal?
           (let ([dot-pos (string-index s #\. i)])
             (when dot-pos
               (set! i (add1 dot-pos)))))
         (when (and decimal? (< i n) (char-ci=? (string-ref s i) #\e))
           (set! exponent? (parse-exponent s (add1 i)))
           (set! i (if exponent? n i)))
         (and decimal? (or (not exponent?) (and exponent? (= i n))) (= i n)))])))