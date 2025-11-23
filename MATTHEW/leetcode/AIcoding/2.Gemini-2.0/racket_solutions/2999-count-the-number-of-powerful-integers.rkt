(define (count-powerful-integers start finish limit s)
  (define s-str (number->string s))
  (define len-s (string-length s-str))

  (define (count-less-than n)
    (define n-str (number->string n))
    (define len-n (string-length n-str))
    (define count 0)

    (define (helper idx prefix)
      (cond
        [(= idx len-s) (set! count (+ count 1))]
        [else
         (define max-digit (if (< idx (- len-n len-s)) 9 (string->number (substring n-str (+ idx (- len-n len-s)) (+ idx (- len-n len-s) 1)))))
         (for ([digit (in-range 0 (+ max-digit 1))])
           (define new-prefix (+ (* prefix 10) digit))
           (if (or (< idx (- len-n len-s)) (<= digit max-digit))
               (helper (+ idx 1) new-prefix)))]))

    (helper 0 0)
    count)

  (define (count-greater-than-or-equal n)
    (if (>= n start) 1 0))

  (define (is-powerful? n)
    (define n-str (number->string n))
    (if (< (string-length n-str) len-s)
        #f
        (equal? (substring n-str (- (string-length n-str) len-s)) s-str)))

  (define (solve finish)
    (if (<= finish 0)
        0
        (let loop ([curr finish] [acc 0])
          (cond
            [(< curr start) acc]
            [else
             (if (and (is-powerful? curr) (<= curr limit))
                 (loop (- curr 1) (+ acc 1))
                 (loop (- curr 1) acc))]))))

  (define (count-between start finish limit s)
    (let loop ([curr finish] [acc 0])
          (cond
            [(< curr start) acc]
            [else
             (if (and (is-powerful? curr) (<= curr limit))
                 (loop (- curr 1) (+ acc 1))
                 (loop (- curr 1) acc))]))
    )

  (count-between start finish limit s))