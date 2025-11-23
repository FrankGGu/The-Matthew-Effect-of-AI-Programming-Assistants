(define (check-inclusion s1 s2)
  (define s1-len (string-length s1))
  (define s2-len (string-length s2))

  (cond
    [(> s1-len s2-len) #f]
    [else
     (define (char->idx c)
       (- (char->integer c) (char->integer #\a)))

     (define (make-freq-vector)
       (make-vector 26 0))

     (define (vectors-equal? v1 v2)
       (for/and ([i (in-range 26)])
         (= (vector-ref v1 i) (vector-ref v2 i))))

     (define s1-freq (make-freq-vector))
     (for ([c (in-string s1)])
       (vector-set! s1-freq (char->idx c) (+ (vector-ref s1-freq (char->idx c)) 1)))

     (define window-freq (make-freq-vector))

     (for ([i (in-range s1-len)])
       (vector-set! window-freq (char->idx (string-ref s2 i))
                    (+ (vector-ref window-freq (char->idx (string-ref s2 i))) 1)))

     (if (vectors-equal? s1-freq window-freq)
         #t
         (let loop ([i s1-len])
           (cond
             [(= i s2-len) #f]
             [else
              (define char-to-remove (string-ref s2 (- i s1-len)))
              (define char-to-add (string-ref s2 i))

              (vector-set! window-freq (char->idx char-to-remove)
                           (- (vector-ref window-freq (char->idx char-to-remove)) 1))
              (vector-set! window-freq (char->idx char-to-add)
                           (+ (vector-ref window-freq (char->idx char-to-add)) 1))

              (if (vectors-equal? s1-freq window-freq)
                  #t
                  (loop (+ i 1)))]))))))