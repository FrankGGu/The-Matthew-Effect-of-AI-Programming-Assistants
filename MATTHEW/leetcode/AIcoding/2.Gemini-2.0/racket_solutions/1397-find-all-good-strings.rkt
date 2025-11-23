(define (find-good-strings n s1 s2 evil)
  (define m (string-length evil))
  (define MOD 1000000007)

  (define (compute-lps evil)
    (define len (string-length evil))
    (define lps (make-vector len 0))
    (let loop ([i 1] [length 0])
      (cond
        [(>= i len) lps]
        [(char=? (string-ref evil i) (string-ref evil length))
         (vector-set! lps i (+ length 1))
         (loop (+ i 1) (+ length 1))]
        [(> length 0)
         (loop i (vector-ref lps (- length 1)))]
        [else (loop (+ i 1) 0)]))
    )

  (define lps (compute-lps evil))

  (define memo (make-hash))

  (define (dp index less1 less2 evil-index)
    (let ([key (list index less1 less2 evil-index)])
      (cond
        [(hash-has-key? memo key) (hash-ref memo key)]
        [(= index n) (if (< evil-index m) 1 0)]
        [else
         (let loop ([c (if less1 #\a (string-ref s1 index))]
                    [upper-bound (if less2 #\z (string-ref s2 index))]
                    [sum 0])
           (cond
             [(> c upper-bound) sum]
             [else
              (let* ([new-evil-index (let loop ([k evil-index])
                                         (cond
                                           [(= k m) m]
                                           [(and (< k m) (char=? (string-ref evil k) c)) (+ k 1)]
                                           [(> k 0) (loop (vector-ref lps (- k 1)))]
                                           [else 0]))]
                     [new-less1 (or less1 (char>? c (string-ref s1 index)))]
                     [new-less2 (or less2 (char<? c (string-ref s2 index)))]
                     [result (dp (+ index 1) new-less1 new-less2 new-evil-index)])
                (loop (integer->char (+ (char->integer c) 1)) upper-bound (modulo (+ sum result) MOD))))
           (let ([result (loop c upper-bound 0)])
             (hash-set! memo key result)
             result)]))))

  (dp 0 #f #f 0))