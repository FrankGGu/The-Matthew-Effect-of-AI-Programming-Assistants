#lang racket

(define (solve n-str)
  (let ((N (string->number n-str)))

    (define (calculate-sum k m N-target)
      (let loop ((i 0) (current-power 1) (current-sum 0))
        (cond
          ((= i m) current-sum)
          (else
           (let ((next-sum (+ current-sum current-power)))
             (if (> next-sum N-target)
                 (add1 N-target)
                 (if (= i (sub1 m))
                     (loop (add1 i) 0 next-sum)
                     (let ((next-power (* current-power k)))
                       (if (> next-power N-target)
                           (add1 N-target)
                           (loop (add1 i) next-power next-sum))))))))))

    (let ((max-m (add2 (floor (/ (log N) (log 2))))))

      (let loop-m ((m max-m))
        (if (< m 3)
            (number->string (sub1 N))

            (let* ((k-upper-bound (floor (expt N (exact-rational 1 (sub1 m)))))
                   (k-lower-bound 2))

              (let search-k ((L k-lower-bound) (R k-upper-bound))
                (if (> L R)
                    (loop-m (sub1 m))

                    (let ((mid (floor (/ (+ L R) 2))))
                      (if (< mid 2)
                          (search-k 2 R)
                          (let ((current-sum (calculate-sum mid m N)))
                            (cond
                              ((= current-sum N) (number->string mid))
                              ((< current-sum N) (search-k (add1 mid) R))
                              (else (search-k L (sub1 mid)))))))))))))))