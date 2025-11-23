(define (add-operators num target)
  (define (helper expr current-num prev-val mult-val index)
    (cond
      [(equal? index (string-length num))
       (if (equal? current-num target)
           (list expr)
           '())]
      [else
       (let loop ([i index] [curr-str ""])
         (cond
           [(equal? i (string-length num)) '()]
           [else
            (let* ([curr-str (string-append curr-str (string (string-ref num i)))]
                   [curr-val (string->number curr-str)])
              (cond
                [(and (not (equal? (string-length curr-str) 1)) (equal? (string-ref curr-str 0) #\0)) '()]
                [else
                 (append
                  (helper (string-append expr (string-append "+" curr-str)) (+ current-num curr-val) curr-val curr-val (+ i 1))
                  (helper (string-append expr (string-append "-" curr-str)) (- current-num curr-val) (- curr-val) curr-val (+ i 1))
                  (helper (string-append expr (string-append "*" curr-str)) (+ current-num (- prev-val (* mult-val curr-val))) (* mult-val curr-val) mult-val (+ i 1))
                  (loop (+ i 1) curr-str))]))]))]))
  (let loop ([i 0] [curr-str ""])
    (cond
      [(equal? i (string-length num)) '()]
      [else
       (let* ([curr-str (string-append curr-str (string (string-ref num i)))]
              [curr-val (string->number curr-str)])
         (cond
           [(and (not (equal? (string-length curr-str) 1)) (equal? (string-ref curr-str 0) #\0)) '()]
           [else
            (append
             (helper curr-str curr-val curr-val curr-val (+ i 1))
             (loop (+ i 1) curr-str))]))]))
  )