(define/contract (relocate-marbles marbles move-from move-to)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let loop ([marbles (list->set marbles)]
             [from move-from]
             [to move-to])
    (if (null? from)
        (sort (set->list marbles) <)
        (let ([f (car from)]
              [t (car to)])
          (if (set-member? marbles f)
              (loop (set-add (set-remove marbles f) t) (cdr from) (cdr to))
              (loop marbles (cdr from) (cdr to)))))))