(define (abbreviate-product left right)
  (let* ([zeros 0]
         [prefix-val 1]
         [suffix-val 1]
         [log10-P-prime-sum 0.0]
         ; max-prefix-digits should be large enough to reliably extract first 5 digits
         ; and distinguish from numbers with <= 10 digits. 12 is a safe choice.
         [max-prefix-digits 12] 
         [prefix-threshold (expt 10 max-prefix-digits)]
         [suffix-mod (expt 10 10)])

    (for-each (lambda (i)
                (let loop ([current i])
                  (cond
                    [(zero? (remainder current 5))
                     (set! zeros (+ zeros 1))
                     (loop (quotient current 5))]
                    [(zero? (remainder current 2))
                     (loop (quotient current 2))]
                    [else
                     (set! log10-P-prime-sum (+ log10-P-prime-sum (log current 10)))
                     (set! prefix-val (* prefix-val current))
                     (set! suffix-val (* suffix-val current))
                     (when (>= prefix-val prefix-threshold)
                       (set! prefix-val (quotient prefix-val 10)))
                     (set! suffix-val (remainder suffix-val suffix-mod))]))
                )
              (build-list (- right left -1) (lambda (j) (+ left j))))

    (let* ([P-prime-len (if (<= log10-P-prime-sum 0.0) 1 (+ (floor log10-P-prime-sum) 1))]
           [prefix-str (number->string prefix-val)]
           [suffix-str (number->string suffix-val)])

      (cond
        [(<= P-prime-len 10)
         (if (zero? zeros)
             prefix-str
             (string-append prefix-str "e" (number->string zeros)))]
        [else ; P-prime-len > 10
         (let* ([first-5 (substring prefix-str 0 5)]
                ; Pad suffix-str with leading zeros if it has less than 10 digits
                [suffix-str-padded (string-append (make-string (- 10 (string-length suffix-str)) #\0) suffix-str)]
                [last-5 (substring suffix-str-padded (- (string-length suffix-str-padded) 5))])
           (string-append first-5 "..." last-5 "e" (number->string zeros)))]))))