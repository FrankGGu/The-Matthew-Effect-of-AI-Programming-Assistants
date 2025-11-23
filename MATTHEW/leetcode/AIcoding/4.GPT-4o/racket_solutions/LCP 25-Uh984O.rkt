(define (most-visited n rounds)
  (define start (car rounds))
  (define end (car (last rounds)))
  (if (< start end)
      (range start (+ end 1))
      (append (range start (+ n 1)) (range 1 (+ end 1)))))

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (+ start 1) end)))
)

(most-visited 4 '(1 3 1 2))