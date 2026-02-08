(define (longest-happy-string a b c)
  (define (helper a b c prev count)
    (if (and (= a 0) (= b 0) (= c 0))
        ""
        (define max-char 
          (if (and (>= a b) (>= a c) (not (= prev 0))) 
              (if (> a 2) 2 1)
              (if (and (>= b a) (>= b c) (not (= prev 1)))
                  (if (> b 2) 1 0)
                  (if (and (>= c a) (>= c b) (not (= prev 2)))
                      (if (> c 2) 0 0) 
                      0))))
        (define char 
          (cond 
            [(= max-char 2) (set! a (- a 1)) #\a]
            [(= max-char 1) (set! b (- b 1)) #\b]
            [(= max-char 0) (set! c (- c 1)) #\c]
            [else (if (> prev 0) #\a #\b)])))
    (if (or (and (= max-char 2) (> count 1))
            (and (= max-char 1) (> count 2)))
        ""
        (string-append (string char) (helper a b c (if (= char #\a) 0 (if (= char #\b) 1 2)) (if (= char #\a) (add1 count) 1)))))
  (helper a b c -1 0))

(longest-happy-string 1 1 7)