(define (max-difference-even-odd-frequency nums)
  (let loop ((nums nums) (even-freq 0) (odd-freq 0))
    (cond
      ((null? nums) (abs (- even-freq odd-freq)))
      ((even? (car nums)) (loop (cdr nums) (+ even-freq 1) odd-freq))
      (else (loop (cdr nums) even-freq (+ odd-freq 1))))))