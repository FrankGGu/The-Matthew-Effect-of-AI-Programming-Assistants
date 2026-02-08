(define (construct-smallest-number s)
  (let ((n (string-length s)))
    (let loop ((i 0) (current-num 1) (current-stack '()) (res-nums '()))
      (cond
        ((> i n)
         (string-join (map number->string (reverse res-nums)) ""))
        (else
         (let ((next-stack (cons current-num current-stack)))
           (if (or (= i n) (char=? (string-ref s i) #\I))
               (let pop-all ((st next-stack) (new-res-nums res-nums))
                 (if (null? st)
                     (loop (+ i 1) (+ current-num 1) '() new-res-nums)
                     (pop-all (cdr st) (cons (car st) new-res-nums))))
               (loop (+ i 1) (+ current-num 1) next-stack res-nums))))))))