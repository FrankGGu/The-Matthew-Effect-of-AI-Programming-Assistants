(define (count-pairs time-formats)
  (define (to-minutes s)
    (let* ([h (string->number (substring s 0 2))]
           [m (string->number (substring s 3 5))])
      (+ (* h 60) m)))

  (define (mod1440 x) (modulo x 1440))

  (define freq (make-hash))

  (for-each
   (lambda (s)
     (let ([t (mod1440 (to-minutes s))])
       (hash-update! freq t add1 0)))
   time-formats)

  (define result 0)

  (for ([k (in-hash-keys freq)])
    (let ([v (hash-ref freq k)])
      (if (= k 0)
          (set! result (+ result (* v (- v 1))))
          (let ([complement (mod1440 (- 1440 k))])
            (when (hash-has-key? freq complement)
              (set! result (+ result (* v (hash-ref freq complement))))))))

  (quotient result 2))