(define/contract (add-rungs rungs dist)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([prev 0] [rungs rungs] [added 0])
    (if (null? rungs)
        added
        (let ([current (car rungs)])
          (if (> (- current prev) dist)
              (let ([diff (- current prev)]
                    [steps (quotient (- diff 1) dist)])
                (loop current (cdr rungs) (+ added steps)))
              (loop current (cdr rungs) added))))))