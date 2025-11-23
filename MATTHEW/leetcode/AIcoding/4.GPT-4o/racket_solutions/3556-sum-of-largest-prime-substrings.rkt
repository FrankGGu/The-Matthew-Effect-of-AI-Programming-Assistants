(define (is-prime n)
  (if (< n 2) #f
      (let loop ((i 2))
        (cond ((> i (sqrt n)) #t)
              ((zero? (modulo n i)) #f)
              (else (loop (+ i 1)))))))

(define (largest-prime-substring s)
  (define (helper substr)
    (if (string? substr)
        (let ((num (string->number substr)))
          (if (and num (is-prime num)) num 0))
        0))
  (define (substrings str)
    (for/fold ([res '()]) ([i (in-range (string-length str))])
      (for/fold ([temp res]) ([j (in-range i (string-length str))])
        (let ((sub (substring str i (add1 j))))
          (cons (helper sub) temp)))))
  (apply + (remove (lambda (x) (zero? x)) (substrings s))))

(define (sum-of-largest-prime-substrings s)
  (largest-prime-substring s))

(sum-of-largest-prime-substrings "123456789")