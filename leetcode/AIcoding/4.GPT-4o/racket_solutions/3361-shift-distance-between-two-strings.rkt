(define (shiftDistance A B)
  (define (shift s n)
    (substring s n) (substring s 0 n))
  (define (is-shifted? a b)
    (let loop ((i 0))
      (cond
        [(= i (string-length a)) #f]
        [(equal? (shift a i) b) #t]
        [else (loop (+ i 1))])))
  (if (not (= (string-length A) (string-length B))) -1
      (if (is-shifted? A B) 0 1)))

(define (shiftDistance A B)
  (if (not (= (string-length A) (string-length B))) -1
      (if (or (equal? A B) (equal? (shift A 1) B)) 0 1)))