(define (permutations m r)
  (if (< r 0) 0
      (for/product ([i (in-range r)])
        (- m i))))

(define (count-special-integers n)
  (define n-str (number->string n))
  (define L (string-length n-str))
  (define n-digits (map (lambda (c) (- (char->integer c) (char->integer #\0)))
                        (string->list n-str)))

  (define total-count 0)

  (for ([k (in-range 1 L)])
    (set! total-count (+ total-count (* 9 (permutations 9 (- k 1))))))

  (define (count-L-digits current-idx current-mask)
    (if (= current-idx L)
        1
        (let ([digit-n (list-ref n-digits current-idx)])
          (define current-L-digit-count 0)
          (define d-start (if (= current-idx 0) 1 0))

          (for ([d (in-range d-start digit-n)])
            (when (= (logand current-mask (arithmetic-shift 1 d)) 0)
              (define remaining-digits (- L 1 current-idx))
              (set! current-L-digit-count
                    (+ current-L-digit-count
                       (permutations (- 9 current-idx) remaining-digits)))))

          (if (not (= (logand current-mask (arithmetic-shift 1 digit-n)) 0))
              current-L-digit-count
              (let ([next-mask (logior current-mask (arithmetic-shift 1 digit-n))])
                (+ current-L-digit-count (count-L-digits (+ current-idx 1) next-mask)))))))

  (set! total-count (+ total-count (count-L-digits 0 0)))

  total-count)