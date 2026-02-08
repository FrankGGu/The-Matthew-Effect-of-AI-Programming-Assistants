(define/contract (find-min-difference timePoints)
  (-> (listof string?) exact-integer?)
  (define (time->minutes time)
    (let* ([parts (string-split time ":")]
           [hours (string->number (first parts))]
           [minutes (string->number (second parts))])
      (+ (* hours 60) minutes)))

  (define minutes-list (sort (map time->minutes timePoints) <))
  (define n (length minutes-list))
  (define min-diff 1440)

  (for ([i (in-range n)])
    (define j (modulo (add1 i) n))
    (define diff (modulo (- (list-ref minutes-list j) (list-ref minutes-list i)) 1440)
    (set! min-diff (min min-diff diff)))

  min-diff)