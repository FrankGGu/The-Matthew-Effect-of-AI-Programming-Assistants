(define (is-number s)
  (define (digit? c)
    (char<=? #\0 c #\9))

  (define (sign? c)
    (or (char=? c #\+) (char=? c #\-)))

  (define (integer? s start end)
    (if (>= start end)
        #f
        (let ((c (string-ref s start)))
          (if (sign? c)
              (if (= (add1 start) end)
                  #f
                  (digits? s (add1 start) end))
              (digits? s start end)))))

  (define (digits? s start end)
    (if (>= start end)
        #f
        (let loop ((i start))
          (if (>= i end)
              (> i start)
              (if (digit? (string-ref s i))
                  (loop (add1 i))
                  #f)))))

  (define (decimal? s start end)
    (if (>= start end)
        #f
        (let ((c (string-ref s start)))
          (if (sign? c)
              (let ((after-sign (add1 start)))
                (if (>= after-sign end)
                    #f
                    (let ((next (string-ref s after-sign)))
                      (if (char=? next #\.)
                          (digits? s (+ after-sign 1) end)
                          (let loop ((i after-sign) (dot? #f))
                            (cond
                              [(>= i end) (and dot? (> i after-sign))]
                              [(char=? (string-ref s i) #\.)
                               (if dot?
                                   #f
                                   (loop (add1 i) #t))]
                              [(digit? (string-ref s i))
                               (loop (add1 i) dot?)]
                              [else #f])))))))
              (let loop ((i start) (dot? #f))
                (cond
                  [(>= i end) (and dot? (> i start))]
                  [(char=? (string-ref s i) #\.)
                   (if dot?
                       #f
                       (loop (add1 i) #t))]
                  [(digit? (string-ref s i))
                   (loop (add1 i) dot?)]
                  [else #f]))))))

  (define (scientific? s start end)
    (let loop ((i start) (seen-e? #f) (seen-dot? #f))
      (cond
        [(>= i end) #f]
        [(char=? (string-ref s i) #\e)
         (if (or seen-e? (= i start) (= i (sub1 end)))
             #f
             (and (or (integer? s (add1 i) end)
                  (or (digits? s start i)
                      (decimal? s start i))))]
        [else (loop (add1 i) seen-e? seen-dot?)])))

  (let* ((s (string-trim s))
         (len (string-length s)))
    (or (integer? s 0 len)
        (decimal? s 0 len)
        (scientific? s 0 len))))