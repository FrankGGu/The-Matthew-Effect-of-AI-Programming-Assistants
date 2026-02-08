(define (min-anagram-concat s t)
  (define (char-counts str)
    (let ((counts (make-vector 26 0)))
      (for ((c (in-string str)))
        (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
      counts))

  (define s-counts (char-counts s))
  (define t-counts (char-counts t))

  (define (check-anagram? str)
    (let ((str-counts (char-counts str)))
      (andmap (lambda (i) (= (vector-ref str-counts i) (vector-ref s-counts i))) (range 26))))

  (define (solve t)
    (let loop ((i 0) (res 0))
      (cond
        ((>= i (string-length t)) res)
        (else
          (let loop2 ((j i))
            (cond
              ((>= j (string-length t)) (+ res (string-length t) (- i)))
              (else
                (let ((sub (substring t i (+ j 1))))
                  (if (check-anagram? sub)
                      (loop (+ j 1) (+ res (string-length s)))
                      (loop2 (+ j 1))))))))))

  (solve t))