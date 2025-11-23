(define (findXValue(arr x))
  (let loop ((i 0))
    (cond
      ((= i (length arr)) -1)
      ((= (list-ref arr i) x) i)
      (else (loop (+ i 1))))))

(define (findXValueOfArrayI arr x)
  (findXValue arr x))