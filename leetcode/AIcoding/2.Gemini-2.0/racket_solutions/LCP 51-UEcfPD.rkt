(define (count-combinations satisfaction)
  (define n (vector-length satisfaction))
  (define (helper index remaining)
    (cond
      [(< remaining 0) 0]
      [(= index n) (if (= remaining 0) 1 0)]
      [else (+ (helper (+ index 1) remaining)
               (helper (+ index 1) (- remaining (vector-ref satisfaction index))))]))
  (helper 0 400))

(define (max-satisfaction satisfaction)
  (define n (length satisfaction))
  (define (count-combinations current-satisfaction)
    (define m (length current-satisfaction))
    (define (helper index remaining)
      (cond
        [(< remaining 0) 0]
        [(= index m) (if (= remaining 0) 1 0)]
        [else (+ (helper (+ index 1) remaining)
                 (helper (+ index 1) (- remaining (vector-ref current-satisfaction index))))]))
    (helper 0 400))

  (define (solve index current-list)
    (cond
      [(= index n)
       (if (null? current-list)
           0
           (count-combinations (list->vector current-list)))]
      [else
       (max (solve (+ index 1) current-list)
            (solve (+ index 1) (append current-list (list (list-ref satisfaction index)))))]))

  (solve 0 '()))

(define (count-ways n satisfaction)
  (define (helper index remaining)
    (cond
      [(< remaining 0) 0]
      [(= index n) (if (= remaining 0) 1 0)]
      [else (+ (helper (+ index 1) remaining)
               (helper (+ index 1) (- remaining (list-ref satisfaction index))))]))
  (helper 0 400))

(define (solve satisfaction)
  (count-ways (length satisfaction) satisfaction))