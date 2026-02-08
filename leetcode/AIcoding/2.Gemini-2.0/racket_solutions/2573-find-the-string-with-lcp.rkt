(define (find-the-string-lcp lcp)
  (define n (vector-length lcp))
  (define ans (make-string n #\0))
  (define next-char #\a)
  (define char-map (make-hash))

  (define (get-char i)
    (hash-ref char-map i #f))

  (define (set-char! i c)
    (hash-set! char-map i c))

  (define (find-string)
    (for/list ([i (in-range n)])
      (cond
        [(get-char i) (get-char i)]
        [else
         (set-char! i next-char)
         (set! next-char (integer->char (+ (char->integer next-char) 1)))
         (get-char i)])))

  (define res (find-string))
  (string->vector res)

  (define (check-lcp str)
    (define new-lcp (make-vector n (make-vector n 0)))
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (if (and (equal? (vector-ref str i) (vector-ref str j)))
            (if (and (< i (- n 1)) (< j (- n 1)))
                (vector-set! (vector-ref new-lcp i) j (+ 1 (vector-ref (vector-ref new-lcp (+ i 1)) (+ j 1))))
                (vector-set! (vector-ref new-lcp i) j 1))
            (vector-set! (vector-ref new-lcp i) j 0))))

    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (not (equal? (vector-ref (vector-ref new-lcp i) j) (vector-ref (vector-ref lcp i) j)))
          (return #f))))
    #t)

  (if (check-lcp (string->vector (list->string res)))
      (list->string res)
      "")
  )