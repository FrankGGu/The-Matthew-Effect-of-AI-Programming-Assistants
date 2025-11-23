(define (largest-number-after-mutating-substring num change)
  (define n (string-length num))
  (define num-list (string->list num))
  (define change-list (string->list change))

  (define (char->digit c)
    (- (char->integer c) (char->integer #\0)))

  (define (digit->char d)
    (integer->char (+ d (char->integer #\0))))

  (define (mutate-substring num-list change-list)
    (let loop ([i 0] [start #f] [end #f])
      (cond
        [(= i n)
         (cond
           [(and start end)
            (let ([mutated-num-list
                   (list-update num-list
                                (lambda (idx char)
                                  (digit->char (list-ref change-list (char->digit char))))
                                (range start (+ end 1)))])
              (list->string mutated-num-list))]
           [else
            (list->string num-list)])]
        [else
         (let ([digit (char->digit (list-ref num-list i))]
               [change-digit (list-ref change-list digit)])
           (cond
             [(and (not start) (< digit (char->digit change-digit)))
              (loop i i i)]
             [(and start (= i end) (= digit (char->digit change-digit)))
              (loop (+ i 1) start (+ i 1))]
             [(and start (= i end) (> digit (char->digit change-digit)))
              (loop (+ i 1) start end)]
             [(and start (< digit (char->digit change-digit)))
              (loop (+ i 1) start (+ i 1))]
             [else
              (loop (+ i 1) start end)]))]))

  (mutate-substring num-list change-list))