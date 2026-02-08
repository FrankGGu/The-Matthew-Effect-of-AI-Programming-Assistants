(define (find-all-duplicates nums)
  (let* ([n (length nums)]
         [v (list->vector nums)]
         [duplicates '()])
    (for ([i (in-range n)])
      (let* ([current-val (vector-ref v i)]
             [idx-to-check (- (abs current-val) 1)])
        (if (< (vector-ref v idx-to-check) 0)
            (set! duplicates (cons (abs current-val) duplicates))
            (vector-set! v idx-to-check (- (vector-ref v idx-to-check))))))
    (reverse duplicates)))