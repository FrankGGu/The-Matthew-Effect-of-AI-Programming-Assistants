#lang racket

(define (nearest-palindrome n)
  (define (is-pal s)
    (equal? s (reverse s)))

  (define (to-string x)
    (number->string x))

  (define (to-int s)
    (string->number s))

  (define (make-pal s)
    (let* ([len (string-length s)]
           [mid (quotient len 2)]
           [left (substring s 0 mid)]
           [right (if (even? len) left (substring s 0 (add1 mid)))]
           [pal (string-append left (reverse right))])
      (to-int pal)))

  (define (generate-candidates s)
    (let ([len (string-length s)])
      (let ([candidates '()])
        (set! candidates (cons (to-int (string-append "9" (make-string (- len 1) #\9))) candidates))
        (set! candidates (cons (to-int (string-append "1" (make-string (- len 1) #\0) "1")) candidates))
        (let ([mid (quotient len 2)])
          (let ([prefix (substring s 0 mid)])
            (let ([num (to-int prefix)])
              (set! candidates (cons (make-pal (string-append prefix (number->string num))) candidates))
              (set! candidates (cons (make-pal (string-append prefix (number->string (add1 num)))) candidates))
              (set! candidates (cons (make-pal (string-append prefix (number->string (sub1 num)))) candidates)))))
        candidates)))

  (define (min-diff candidate n)
    (abs (- candidate n)))

  (define (find-closest candidates n)
    (let ([min-candidate (car candidates)]
          [min-diff (min-diff (car candidates) n)])
      (for-each (lambda (c)
                  (let ([d (min-diff c n)])
                    (cond [(< d min-diff)
                           (set! min-candidate c)
                           (set! min-diff d)]
                          [(and (= d min-diff) (< c min-candidate))
                           (set! min-candidate c)])))
                (cdr candidates))
      min-candidate))

  (let ([s (to-string n)])
    (if (= (string-length s) 1)
        (if (= n 0) 1 (- n 1))
        (let ([candidates (generate-candidates s)])
          (find-closest candidates n)))))