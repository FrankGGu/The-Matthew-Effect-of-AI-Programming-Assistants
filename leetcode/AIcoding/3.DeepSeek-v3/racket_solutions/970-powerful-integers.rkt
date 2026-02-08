(define/contract (powerful-integers x y bound)
  (-> exact-integer? exact-integer? exact-integer? (listof exact-integer?))
  (define (get-powers base)
    (let loop ([power 1] [powers '()])
      (if (or (zero? base) (> power bound))
          (reverse powers)
          (loop (* power base) (cons power powers)))))
  (define x-powers (get-powers x))
  (define y-powers (get-powers y))
  (define result (mutable-set))
  (for* ([xp x-powers]
         [yp y-powers]
         [sum (+ xp yp)]
         #:when (<= sum bound))
    (set-add! result sum))
  (sort (set->list result) <))