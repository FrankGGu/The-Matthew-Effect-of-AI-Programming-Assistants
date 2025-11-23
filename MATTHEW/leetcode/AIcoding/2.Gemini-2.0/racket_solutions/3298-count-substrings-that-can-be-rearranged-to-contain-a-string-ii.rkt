(define (count-substrings s t)
  (define n (string-length s))
  (define m (string-length t))
  (define mod 1000000007)

  (define (count-valid-substrings)
    (letrec ((dp (make-vector (+ n 1) (make-vector (+ m 1) (make-vector (+ 26 1) 0))))
             (valid? (lambda (freq) (for/and ((i (in-range m))) (> (vector-ref freq (char->integer (string-ref t i))) 0))))
             (count (lambda (i j freq)
                      (cond
                        ((= j m)
                         (if (valid? freq) 1 0))
                        ((= i n) 0)
                        (else
                         (let* ((c (char->integer (string-ref s i)) (- (char->integer #\a)))
                                (new-freq (vector-copy freq)))
                           (vector-set! new-freq c (+ (vector-ref new-freq c) 1))
                           (let ((without-s (vector-ref (vector-ref dp (+ i 1) j) freq))
                                 (with-s (vector-ref (vector-ref dp (+ i 1) (+ j 1)) new-freq)))
                             (if (= (vector-ref (vector-ref dp (+ i 1) j) freq) 0)
                                 (vector-set! (vector-ref dp (+ i 1) j) freq
                                              (count (+ i 1) j freq)))
                             (if (= (vector-ref (vector-ref dp (+ i 1) (+ j 1)) new-freq) 0)
                                 (vector-set! (vector-ref dp (+ i 1) (+ j 1)) new-freq
                                              (count (+ i 1) (+ j 1) new-freq)))
                             (modulo (+ (vector-ref (vector-ref dp (+ i 1) j) freq)
                                        (vector-ref (vector-ref dp (+ i 1) (+ j 1)) new-freq)) mod)))))))))
      (count 0 0 (make-vector 26 0))))

  (count-valid-substrings))