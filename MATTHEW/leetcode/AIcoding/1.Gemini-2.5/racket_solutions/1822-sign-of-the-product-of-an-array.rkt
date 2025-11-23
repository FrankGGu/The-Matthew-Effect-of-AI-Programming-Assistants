(define (array-sign nums)
  (let loop ((numbers nums) (current-sign 1))
    (cond
      ((empty? numbers) current-sign)
      ((zero? (car numbers)) 0)
      ((< (car numbers) 0) (loop (cdr numbers) (* current-sign -1)))
      (else (loop (cdr numbers) current-sign)))))