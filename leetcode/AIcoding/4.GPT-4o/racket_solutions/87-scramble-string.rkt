(define (is-scramble s1 s2)
  (define (helper s1 s2)
    (if (string=? s1 s2)
        #t
        (let* ([n (string-length s1)]
               [s1-sorted (string->list (string-sort s1))]
               [s2-sorted (string->list (string-sort s2))])
          (if (not (equal? s1-sorted s2-sorted))
              #f
              (for/or ([i (in-range 1 n)])
                (or (and (helper (substring s1 0 i) (substring s2 0 i))
                         (helper (substring s1 i) (substring s2 i)))
                    (and (helper (substring s1 0 i) (substring s2 (- n i)))
                         (helper (substring s1 i) (substring s2 0 (- n i))))))))))
  (helper s1 s2))

(define (isScramble s1 s2)
  (is-scramble s1 s2))