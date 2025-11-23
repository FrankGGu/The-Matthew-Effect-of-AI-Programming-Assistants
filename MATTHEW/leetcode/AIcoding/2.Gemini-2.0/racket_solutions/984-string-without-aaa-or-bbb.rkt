(define (str-without-3a3b a b)
  (define (helper a b s)
    (cond
      [(and (= a 0) (= b 0)) s]
      [(> a b)
       (cond
         [(and (> a 1) (or (empty? s) (not (equal? (last s) "a")) (not (equal? (last (drop-right s 1)) "a"))))
          (helper (- a 2) b (string-append s "aa"))]
         [(> b 0) (helper (- a 1) (- b 1) (string-append s "ab"))]
         [else s])]
      [(> b a)
       (cond
         [(and (> b 1) (or (empty? s) (not (equal? (last s) "b")) (not (equal? (last (drop-right s 1)) "b"))))
          (helper a (- b 2) (string-append s "bb"))]
         [(> a 0) (helper (- a 1) (- b 1) (string-append s "ba"))]
         [else s])]
      [else
       (cond
         [(> a 0) (helper (- a 1) (- b 1) (string-append s "ab"))]
         [else s])]))

  (helper a b ""))