(define (sumGame num)
  (define total1 0)
  (define total2 0)
  (define cnt1 0)
  (define cnt2 0)

  (for ([i (in-range (string-length num))])
    (define char (string-ref num i))
    (cond
      [(char=? char #\?) (if (< i 5) (set! cnt1 (+ cnt1 1)) (set! cnt2 (+ cnt2 1)))]
      [(< i 5) (set! total1 (+ total1 (string->number (string (string-ref num i)))))]
      [else (set! total2 (+ total2 (string->number (string (string-ref num i)))))]))

  (define diff1 (- total1 (if (= cnt1 0) 0 (/ total1 (expt 10 cnt1)))))
  (define diff2 (- total2 (if (= cnt2 0) 0 (/ total2 (expt 10 cnt2)))))

  (not (= diff1 diff2)))