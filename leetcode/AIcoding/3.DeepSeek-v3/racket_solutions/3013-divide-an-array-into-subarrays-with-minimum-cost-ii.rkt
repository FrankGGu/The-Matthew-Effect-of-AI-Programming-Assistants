(define/contract (minimum-cost nums k dist)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [nums (list->vector nums)]
         [k-1 (- k 1)]
         [dist+1 (+ dist 1)])
    (let loop ([i 1]
               [prev (make-vector k-1 0)]
               [current (make-vector k-1 +inf.0)])
      (if (>= i n)
          (vector-ref prev (- k-1 1))
          (let ([num (vector-ref nums i)])
            (for ([j (in-range k-1)])
              (if (>= j i)
                  (vector-set! current j +inf.0)
                  (let ([min-prev +inf.0])
                    (for ([l (in-range (max 0 (- j dist+1)) j)])
                      (set! min-prev (min min-prev (vector-ref prev l))))
                    (vector-set! current j (+ num min-prev)))))
            (loop (+ i 1) current (make-vector k-1 +inf.0)))))))