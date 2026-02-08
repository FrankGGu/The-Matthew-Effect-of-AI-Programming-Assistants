(define (minimum-absolute-difference arr x)
  (let* ([n (length arr)]
         [sorted-arr (sort arr <)]
         (define (find-min-diff left right)
           (cond
             ((>= left right) +inf.0)
             (else
              (let* ([mid (floor (/ (+ left right) 2))]
                     [diff (abs (- (list-ref sorted-arr mid) x))]
                     [left-diff (find-min-diff left mid)]
                     [right-diff (find-min-diff (+ mid 1) right)])
                (min diff left-diff right-diff))))))
    (let loop ([i 0] [min-diff +inf.0])
      (if (>= i (- n 1))
          min-diff
          (let* ([target (+ (list-ref arr i) x)]
                 [new-min-diff (min min-diff (find-min-diff 0 n))])
            (loop (+ i 1) new-min-diff))))))

(define (min-absolute-difference arr x)
  (let* ([n (length arr)]
         [result +inf.0])
    (for* ([i (in-range n)]
           [j (in-range n)]
           #:when (not (= i j)))
      (when (>= (abs (- i j)) x)
        (set! result (min result (abs (- (list-ref arr i) (list-ref arr j)))))))
    (if (= result +inf.0)
        -1
        result)))