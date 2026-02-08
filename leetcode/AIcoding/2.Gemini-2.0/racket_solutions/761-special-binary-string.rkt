(define (special-binary-string s)
  (define (helper s)
    (if (string=? s "")
        ""
        (let loop ([i 0] [count 0] [res '()])
          (cond
            [(= i (string-length s)) (apply string-append (reverse res))]
            [(= count 0) (loop (+ i 1) 1 (cons (helper (substring s (+ i 1) (string-length s))) res))]
            [(char=? (string-ref s i) #\1) (loop (+ i 1) (+ count 1) res)]
            [else (if (= count 1)
                      (loop (+ i 1) 0 (cons (substring s 0 (+ i 1)) res))
                      (loop (+ i 1) (- count 1) res))]))))
  (define (compare a b)
    (string>? a b))
  (define result (sort (map helper (split-special s)) compare))
  (apply string-append result))

(define (split-special s)
  (define (helper s i count start result)
    (cond
      [(= i (string-length s))
       (if (= count 0)
           (reverse result)
           (error "Invalid special string"))]
      [(char=? (string-ref s i) #\1)
       (helper s (+ i 1) (+ count 1) start result)]
      [else
       (if (= count 1)
           (helper s (+ i 1) 0 (+ i 1) (cons (substring s start (+ i 1)) result))
           (helper s (+ i 1) (- count 1) start result))]))
  (if (string=? s "")
      '()
      (helper s 0 0 0 '())))