(define (getHappyString n k)
  (let loop ((chars '(#\a #\b #\c)) (current "") (count 0))
    (cond
      [(= (string-length current) n) 
       (set! count (add1 count))
       (if (= count k) current (values))]
      [else
       (for ([ch chars])
         (when (or (string-empty? current) (not (char=? ch (string-ref current (sub1 (string-length current)))))
           (loop (remove ch chars) (string-append current (string ch)) count))]
      [else (values)]))
  (let-values ([(result) (loop '(#\a #\b #\c) "" 0)])
    (if (string? result) result "")))