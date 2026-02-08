(require racket/set)
(require racket/list)
(require racket/bitwise)

(define (minimum-impossible-or nums)
  (let ([all-possible-ors (set)]
        [current-ors-ending-at-prev (set)])

    (for-each (lambda (num)
                (let ([current-ors-ending-at-this (set)])
                  (set! current-ors-ending-at-this (set-add current-ors-ending-at-this num))

                  (for-each (lambda (prev-or-val)
                              (set! current-ors-ending-at-this
                                    (set-add current-ors-ending-at-this (bitwise-ior prev-or-val num))))
                            (set->list current-ors-ending-at-prev))

                  (set! current-ors-ending-at-prev current-ors-ending-at-this)

                  (set! all-possible-ors (set-union all-possible-ors current-ors-ending-at-this))))
              nums)

    (let ([sorted-ors (sort (set->list all-possible-ors) <)])
      (let loop ([expected 1]
                 [remaining-ors sorted-ors])
        (cond
          [(empty? remaining-ors) expected]
          [(= expected (car remaining-ors)) (loop (+ expected 1) (cdr remaining-ors))]
          [else expected])))))