(define/contract (num-friend-requests ages)
  (-> (listof exact-integer?) exact-integer?)
  (define age-count (make-hash))
  (for ([age ages])
    (hash-update! age-count age add1 0))
  (let loop ([keys (sort (hash-keys age-count) <)]
              [res 0])
    (if (null? keys)
        res
        (let* ([x (car keys)]
               [count-x (hash-ref age-count x)]
               [min-y (+ (quotient x 2) 7)]
               [remaining-keys (cdr keys)])
          (let inner-loop ([keys remaining-keys]
                          [res res])
            (if (null? keys)
                (loop remaining-keys res)
                (let* ([y (car keys)]
                       [count-y (hash-ref age-count y)])
                  (if (<= y min-y)
                      (inner-loop (cdr keys) res)
                      (if (> y x)
                          (inner-loop (cdr keys) res)
                          (if (and (= y x) (> count-x 1))
                              (inner-loop (cdr keys) (+ res (* count-x (sub1 count-x))))
                              (inner-loop (cdr keys) (+ res (* count-x count-y))))))))))))))