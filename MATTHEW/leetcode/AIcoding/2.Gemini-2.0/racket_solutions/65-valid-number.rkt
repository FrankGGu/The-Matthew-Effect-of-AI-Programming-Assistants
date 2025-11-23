(define (is-digit? c)
  (and (char>=? c #\0) (char<=? c #\9)))

(define (is-valid-number s)
  (define n (string-length s))
  (define i (box 0))
  (define seen-digit (box #f))
  (define seen-exponent (box #f))
  (define seen-dot (box #f))

  (define (consume)
    (set-box! i (+ (unbox i) 1)))

  (define (peek)
    (if (< (unbox i) n)
        (string-ref s (unbox i))
        #f))

  (define (skip-whitespaces)
    (while (and (< (unbox i) n) (char=? (string-ref s (unbox i)) #\space))
           (consume)))

  (skip-whitespaces)

  (when (or (char=? (peek) #\+) (char=? (peek) #\-))
    (consume))

  (while (and (< (unbox i) n) (is-digit? (peek)))
         (set-box! seen-digit #t)
         (consume))

  (when (char=? (peek) #\.)
    (set-box! seen-dot #t)
    (consume)
    (while (and (< (unbox i) n) (is-digit? (peek)))
           (set-box! seen-digit #t)
           (consume)))

  (when (or (char=? (peek) #\e) (char=? (peek) #\E))
    (when (unbox seen-exponent)
      (return #f))
    (set-box! seen-exponent #t)
    (consume)
    (set-box! seen-digit #f)
    (when (or (char=? (peek) #\+) (char=? (peek) #\-))
      (consume))
    (while (and (< (unbox i) n) (is-digit? (peek)))
           (set-box! seen-digit #t)
           (consume)))

  (skip-whitespaces)

  (and (unbox seen-digit) (= (unbox i) n)))