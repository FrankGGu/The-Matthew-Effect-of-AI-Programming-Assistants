(define (longest-nice-substring s)
  (define (is-nice? substr)
    (let loop ([chars (string->list substr)]
               [lower (make-hash)]
               [upper (make-hash)])
      (cond
        [(null? chars) (and (hash-has-key? lower #\a) (hash-has-key? upper #\A))]
        [else
         (let* ([char (car chars)]
                [is-lower (char<=? #\a char #\z)]
                [is-upper (char<=? #\A char #\Z)])
           (when is-lower
             (hash-set! lower char #t))
           (when is-upper
             (hash-set! upper (char-upcase char) #t))
           (loop (cdr chars) lower upper))])))

  (define (helper start end max-length max-substr)
    (if (>= end (string-length s))
        max-substr
        (let ([substr (substring s start end)])
          (if (is-nice? substr)
              (let ([length (string-length substr)])
                (if (> length max-length)
                    (helper start (+ end 1) length substr)
                    (helper start (+ end 1) max-length max-substr))
                )
              (helper start (+ end 1) max-length max-substr)))))

  (if (zero? (string-length s))
      ""
      (helper 0 1 0 "")))

(longest-nice-substring "YazaAay")