(define (calculate s)
  (let loop ([i 0] [stack '()] [sign 1] [res 0])
    (if (>= i (string-length s))
        res
        (let ([c (string-ref s i)])
          (cond
            [(char-numeric? c)
             (let ([num 0])
               (let num-loop ([j i])
                 (if (and (< j (string-length s)) (char-numeric? (string-ref s j)))
                     (num-loop (+ j 1))
                     (begin
                       (set! num (string->number (substring s i j)))
                       (loop j stack sign (+ res (* sign num)))))))]
            [(char=? c #\+) (loop (+ i 1) stack 1 (+ res (* sign 1)))]
            [(char=? c #\-) (loop (+ i 1) stack -1 (+ res (* sign -1)))]
            [(char=? c #\()
             (loop (+ i 1) (cons (cons res sign) stack) 1 0)]
            [(char=? c #\))
             (let* ([prev (car stack)]
                    [prev-res (car prev)]
                    [prev-sign (cdr prev)])
               (loop (+ i 1) (cdr stack) prev-sign (+ prev-res (* prev-sign res))))]
            [else (loop (+ i 1) stack sign res)])))))