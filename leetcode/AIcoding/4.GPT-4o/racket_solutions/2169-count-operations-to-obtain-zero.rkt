(define (countOperations A B)
  (define count 0)
  (define (helper a b)
    (if (and (= a 0) (= b 0))
        count
        (begin
          (set! count (+ count 1))
          (if (> a b)
              (helper (- a b) b)
              (helper a (- b a)))))
  (helper (abs A) (abs B))
  count)