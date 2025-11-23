(define (countSubstrings s t)
  (define (count-char-freq str)
    (let loop ((chars (string->list str)) (freq (make-hash)))
      (if (null? chars)
          freq
          (begin
            (hash-set! freq (car chars) (+ (hash-ref freq (car chars) 0) 1))
            (loop (cdr chars) freq)))))

  (define s-freq (count-char-freq s))
  (define t-freq (count-char-freq t))

  (define (count-rearrange substr-freq t-freq)
    (for/fold ([count 0]) ([k (in-hash t-freq)])
      (let* ([char (car k)]
             [needed (- (hash-ref t-freq char) (hash-ref substr-freq char 0))])
        (if (< needed 0)
            count
            (+ count (expt 2 needed))))))

  (define substrings (for*/fold ([count 0]) ([i (in-range (string-length s))])
    (for ([j (in-range i (string-length s))])
      (let ([substr (substring s i (+ j 1))])
        (set! count (+ count (count-rearrange (count-char-freq substr) t-freq)))
        count))))

  substrings)