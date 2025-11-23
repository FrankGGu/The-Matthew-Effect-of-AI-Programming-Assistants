(define (next-greater-element-iii n)
  (define MAX-INT (sub1 (expt 2 31)))

  (define (int->digits num)
    (if (= num 0)
        '(0)
        (map (lambda (c) (- (char->integer c) (char->integer #\0)))
             (string->list (number->string num)))))

  (define (digits->int digits)
    (for/fold ([acc 0]) ([d digits])
      (+ (* acc 10) d)))

  (define (find-pivot-index ds)
    (for/first ([i (range (- (length ds) 2) -1 -1))]
                #:when (< (list-ref ds i) (list-ref ds (+ i 1))))
      i)
    (else #f))

  (define (find-swap-index ds pivot-index)
    (let ([pivot-val (list-ref ds pivot-index)])
      (for/first ([j (range (- (length ds) 1) pivot-index -1))]
                  #:when (> (list-ref ds j) pivot-val))
        j)))

  (define (swap ds i j)
    (let* ([val-i (list-ref ds i)]
           [val-j (list-ref ds j)]
           [temp-ds (list-set ds i val-j)])
      (list-set temp-ds j val-i)))

  (let* ([digits (int->digits n)]
         [i (find-pivot-index digits)])

    (if (not i)
        -1
        (let* ([j (find-swap-index digits i)]
               [swapped-digits (swap digits i j)]
               [prefix (take swapped-digits (+ i 1))]
               [suffix (drop swapped-digits (+ i 1))]
               [sorted-suffix (sort suffix <)]
               [result-digits (append prefix sorted-suffix)]
               [result (digits->int result-digits)])

          (if (> result MAX-INT)
              -1
              result)))))