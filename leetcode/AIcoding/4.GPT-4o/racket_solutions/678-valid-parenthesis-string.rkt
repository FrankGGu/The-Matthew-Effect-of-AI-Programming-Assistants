(define (check-valid-string s)
  (define (helper s i open)
    (cond
      [(= i (string-length s)) (= open 0)]
      [(char=? (string-ref s i) #\() (helper s (+ i 1) (+ open 1))]
      [(char=? (string-ref s i) #\)) (and (> open 0) (helper s (+ i 1) (- open 1)))]
      [(char=? (string-ref s i) #\*) (or (helper s (+ i 1) open) 
                                          (helper s (+ i 1) (+ open 1)) 
                                          (and (> open 0) (helper s (+ i 1) (- open 1))))]
      [else #f]))
  (helper s 0 0))

(check-valid-string s)