(define (deserialize s)
  (define (parse-list str)
    (cond
      [(string=? str "[]") '()]
      [else
       (let loop ([str (substring str 1 (sub1 (string-length str)))]
                  [acc '()])
         (cond
           [(string=? str "") (reverse acc)]
           [else
            (let* ([i (find-comma-or-end str)]
                   [token (substring str 0 i)]
                   [rest (if (= i (string-length str)) "" (substring str (add1 i) (string-length str)))])
              (loop rest (cons (deserialize token) acc))))])]))
  (define (find-comma-or-end str)
    (let loop ([i 0] [open-count 0])
      (cond
        [(= i (string-length str)) i]
        [(= open-count 0)
         (if (char=? (string-ref str i) #\,)
             i
             (loop (add1 i) open-count))]
        [else
         (cond
           [(char=? (string-ref str i) #\[) (loop (add1 i) (add1 open-count))]
           [(char=? (string-ref str i) #\]) (loop (add1 i) (sub1 open-count))]
           [else (loop (add1 i) open-count)])])))
  (cond
    [(string=? s "") (list)]
    [(char=? (string-ref s 0) #\[) (parse-list s)]
    [else (string->number s)]))