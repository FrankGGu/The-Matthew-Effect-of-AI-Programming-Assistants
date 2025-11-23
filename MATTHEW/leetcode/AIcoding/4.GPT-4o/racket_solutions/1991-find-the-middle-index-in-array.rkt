(define (find-middle-index nums)
  (let* ((total (apply + nums))
         (left-sum 0))
    (for/fold ([index 0]) ([i (in-range (length nums))])
      (begin
        (if (= left-sum (/ total 2))
            (set! index i))
        (set! left-sum (+ left-sum (list-ref nums i)))
        index))))