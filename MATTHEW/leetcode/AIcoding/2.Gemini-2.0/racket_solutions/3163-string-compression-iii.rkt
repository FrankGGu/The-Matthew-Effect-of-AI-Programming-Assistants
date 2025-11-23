(define (get-length-of-optimal-compression s k)
  (define n (string-length s))
  (define memo (make-hash))

  (define (encode-length cnt)
    (cond
      [(<= cnt 1) 0]
      [(<= cnt 9) 1]
      [(<= cnt 99) 2]
      [else 3]))

  (define (dp i k)
    (cond
      [(<= k 0) (encode-length (length (string-list s))))
      [(>= i n) 0]
      [else
       (hash-ref! memo (list i k)
                 (lambda ()
                   (let* ([del (dp (+ i 1) (- k 1))]
                          [keep (let loop ([j i] [cnt 0] [del-cnt k])
                                  (cond
                                    [(>= j n) (+ (encode-length cnt) 0)]
                                    [(char=? (string-ref s i) (string-ref s j))
                                     (loop (+ j 1) (+ cnt 1) del-cnt)]
                                    [(> del-cnt 0)
                                     (loop (+ j 1) cnt (- del-cnt 1))]
                                    [else
                                     (+ (encode-length cnt) (dp j k))]))])
                     (min del keep))))]))

  (dp 0 k))