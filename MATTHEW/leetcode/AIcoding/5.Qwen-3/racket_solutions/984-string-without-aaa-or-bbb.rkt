(define (str-join lst)
  (apply string-append lst))

(define (generate-string a b)
  (define (helper res a b last)
    (cond [(and (= a 0) (= b 0)) res]
          [(and (= a 0) (> b 0))
           (string-append res (make-string b #\B))]
          [(and (= b 0) (> a 0))
           (string-append res (make-string a #\A))]
          [else
           (let* ([count-a (if (equal? last #\A) 0 2)]
                  [count-b (if (equal? last #\B) 0 2)]
                  [a-possible (min a count-a)]
                  [b-possible (min b count-b)])
             (if (> a-possible b-possible)
                 (helper (string-append res (make-string a-possible #\A)) (- a a-possible) b #\A)
                 (helper (string-append res (make-string b-possible #\B)) a (- b b-possible) #\B)))]))
  (helper "" a b #\0))

(define/contract (valid-sequence a b)
  (-> exact-integer? exact-integer? string?)
  (generate-string a b))