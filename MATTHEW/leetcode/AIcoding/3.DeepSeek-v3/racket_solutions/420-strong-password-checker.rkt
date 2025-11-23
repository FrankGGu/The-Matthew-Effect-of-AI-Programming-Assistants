(define (strong-password-checker password)
  (define n (string-length password))
  (define (has-lower? s)
    (regexp-match? #rx"[a-z]" s))
  (define (has-upper? s)
    (regexp-match? #rx"[A-Z]" s))
  (define (has-digit? s)
    (regexp-match? #rx"[0-9]" s))

  (define missing-types 
    (+ (if (has-lower? password) 0 1)
       (if (has-upper? password) 0 1)
       (if (has-digit? password) 0 1)))

  (define (count-repeats s)
    (let loop ([i 2] [cnt 0] [prev2 #\null] [prev1 (string-ref s 0)])
      (if (>= i n)
          cnt
          (let ([curr (string-ref s i)])
            (if (and (char=? curr prev1) (char=? prev1 prev2))
                (loop (add1 i) (add1 cnt) prev1 curr)
                (loop (add1 i) cnt prev1 curr))))))

  (define repeats (count-repeats password))

  (cond
    [(< n 6) (max (- 6 n) missing-types)]
    [(<= n 20) (max missing-types repeats)]
    [else
     (let* ([delete-count (- n 20)]
            [repeats-list (let loop ([i 2] [res '()] [prev2 #\null] [prev1 (string-ref password 0)])
                            (if (>= i n)
                                (reverse res)
                                (let ([curr (string-ref password i)])
                                  (if (and (char=? curr prev1) (char=? prev1 prev2))
                                      (let ([j i])
                                        (while (and (< j n) (char=? (string-ref password j) curr))
                                          (set! j (add1 j)))
                                        (loop j (cons (- j i) res) (string-ref password (sub1 j)) curr))
                                      (loop (add1 i) res prev1 curr)))))])
            [repeats-list (sort repeats-list <)]
            [replacements 0]
            [repeats-left 0])
       (for ([len (in-list repeats-list)])
         (if (>= delete-count 0)
             (let ([use (min (quotient len 3) delete-count)])
               (set! delete-count (- delete-count use))
               (set! len (- len use))
               (set! replacements (+ replacements (quotient len 3))))
             (set! replacements (+ replacements (quotient len 3)))))
       (set! repeats-left (apply + (map (lambda (x) (quotient x 3)) repeats-list)))
       (+ (- n 20) (max missing-types replacements repeats-left)))]))