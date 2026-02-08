(define (count-stepping-numbers low high)
  (define (num->string n) (number->string n))
  (define (string->num s) (string->number s))

  (define (is-stepping? n)
    (define s (num->string n))
    (cond
      [(<= (string-length s) 1) #t]
      [else
       (let loop ([i 0])
         (cond
           [(= i (- (string-length s) 1)) #t]
           [else
            (let ([c1 (string-ref s i)]
                  [c2 (string-ref s (+ i 1))])
              (cond
                [(or (= (char->integer c1) (+ (char->integer c2) 1))
                     (= (char->integer c1) (- (char->integer c2) 1)))
                 (loop (+ i 1))]
                [else #f]))]))]))

  (define (count-stepping-numbers-below n)
    (let loop ([i 0] [count 0])
      (cond
        [(> i n) count]
        [else
         (if (is-stepping? i)
             (loop (+ i 1) (+ count 1))
             (loop (+ i 1) count))])))

  (- (count-stepping-numbers-below high) (count-stepping-numbers-below (- low 1))))